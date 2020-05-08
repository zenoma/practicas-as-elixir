defmodule Ring do
    @moduledoc"""
    Módulo Ring, implementa anillo de procesos linkados que se envían mensajes
    """
  
  
    @doc"""
    start, Construye el anillo de "n" procesos, que se envían "m" mensajes que son "msg"
    """
    def start(n, m, msg) do
        primero = spawn(fn -> process_setup(n - 1) end)
        Process.register(primero, :first)
        send(:first, {m - 1, msg})
    end


    defp process_setup(0) do
        loop(Process.whereis(:first))
    end

    defp process_setup(n) do
        next_pid = spawn(fn -> process_setup(n - 1) end)
        loop(next_pid)
    end

    defp loop(nil), do: :stop
    defp loop(next_pid) do
        receive do
            {0, _msg} ->
                send(:first, :stop) #Manda mensajes de más, n mensajes concretamente
                loop(next_pid)
            {m, msg} -> 
                IO.puts msg
                send(next_pid, {m - 1, msg})
                loop(next_pid) # Reinicio por si quedan más mensajes
            :stop ->
                send(next_pid, :stop)
        end
    end

end