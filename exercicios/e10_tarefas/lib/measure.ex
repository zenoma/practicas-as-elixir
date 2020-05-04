defmodule Measure do
    
    #Enum.to_list(1..10)
    #Task.async(fun)
    #Task.await(task)
    #Measure.run([{Manipulating, :reverse}, {Manipulating, :flatten}, {Sorting, :quicksort}, {Sorting, :mergesort}], 10000)
    #Measure.run([{Manipulating, :reverse}, {Sorting, :quicksort}, {Manipulating, :reverse}], 10)

    def run(lista_de_funcions, numero_de_elementos) do
        #Create lenght(lista_de_functions) processes who will initialize a list
        #When they end, create another lenght(lista_de_functions) processes who will process the previous lists
        Supervisor.start_link([{Task.Supervisor, name: TaskSupervisor}], strategy: :one_for_one)
        task_list = create_task(length(lista_de_funcions),[], numero_de_elementos)
        do_work(task_list, lista_de_funcions, [])
    end

    def create(n) do 
        Enum.to_list(1..n)
    end

    def create_task(0, task_list, _n_elem) do
        task_list
    end

    def create_task(n, task_list, n_elem) do
        create_task(n-1, task_list ++ [Task.Supervisor.async(TaskSupervisor, fn -> Measure.create(n_elem) end)], n_elem)
    end


    def do_work([], _, task_list) do
        task_list
    end

    def do_work([data_head | data_tail], [{module, func} | func_tail], task_list) do
        do_work(data_tail, func_tail, task_list ++ [Task.Supervisor.async(TaskSupervisor, module, func, [Task.await(data_head)])])
    end




end

# Supervisor.start_link([
#     {Task.Supervisor, name: MyApp.TaskSupervisor}
#   ], strategy: :one_for_one)


# Task.Supervisor.start_child(MyApp.TaskSupervisor, fn -> Measure.create(10) end)
# task = Task.Supervisor.async(MyApp.TaskSupervisor, fn -> Measure.create(10) end)