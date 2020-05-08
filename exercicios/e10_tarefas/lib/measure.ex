defmodule Measure do
    @moduledoc"""
    Módulo Measure, Módulo para estudiar tiempos sobre operaciones sobre listas
    """

    @doc"""
    run, Dado una lista de funciones, un entero "n" genera una lista de tamaño "n"
    la cual es aplicada toda la lista de funciones y devuleve un resumen  de los tiempos de dichas operaciones
    """
    def run(lista_de_funcions, numero_de_elementos) do

        t1 = :erlang.timestamp()
        datos_tasks = task_datos(lista_de_funcions, numero_de_elementos, [])
        datos = await_datos(datos_tasks, [])
        datos_t = :erlang.timestamp() |> :timer.now_diff(t1)
        
        {fun_tasks, names} = task_fun(lista_de_funcions, datos, [], Db.new())
        res = Task.yield_many(fun_tasks, 10000)

        IO.puts(" --------------------------------------------")
        IO.puts("| Creación de datos : #{datos_t/1000000}           sec |")
        print_fun(res, names)
        IO.puts(" --------------------------------------------")
    end

    defp task_datos([], _, tasks), do: tasks
    defp task_datos([h|t], n, tasks) do
        task = Task.async(fn -> crear_datos(h, n) end)
        task_datos(t, n, [task|tasks])
    end

    defp await_datos([], results), do: results
    defp await_datos([task|t], results) do
        res = Task.await(task, :infinity)
        await_datos(t, [res|results])
    end

    defp crear_datos({Manipulating, :flatten}, n), do: lista_de_listas(n, [])
    defp crear_datos(_, n), do: lista_aleatoria(n, [])
    
    defp lista_aleatoria(0, acc), do: acc
    defp lista_aleatoria(n, acc) do
        x = :rand.uniform(1001) - 1
        lista_aleatoria(n-1, [x|acc])
    end
    
    defp lista_de_listas(0, acc), do: acc
    defp lista_de_listas(n, acc) do
        x = :rand.uniform(1001) - 1
        lista_de_listas(n-1, [[x]|acc])
    end
    
    defp task_fun([], _datos, tasks, names), do: {tasks, names}
    defp task_fun([func|t1], [datos|t2], tasks, names) do
        {module, function} = func
        name = String.replace_prefix("#{module}:#{function}", "Elixir.", "")
        task = Task.async(fn -> time_fun(func, [datos]) end)
        task_fun(t1, t2, [task|tasks], Db.write(names, task, name))
    end
    
    defp time_fun({module, fun}, args) do
        t1 = :erlang.timestamp()
        apply(module, fun, args)
        t2 = :erlang.timestamp()
        :timer.now_diff(t2, t1)
    end

    defp print_fun([], _names), do: :ok
    defp print_fun([{task, {:ok, time}}|t], names) do
        {:ok, name} = Db.read(names, task)
        IO.puts("| #{name} : #{time/1000000}           sec |")
        print_fun(t, names)
    end
    defp print_fun([{task, _}|t], names) do
        {:ok, name} = Db.read(names, task)
        Task.shutdown(task, :brutal_kill)
        IO.puts("| #{name} : interrompida        |")
        print_fun(t, names)
    end

end