defmodule Ring do

def start(n, m, msg) do
    second = spawn_link(Ring, :start_process, [n - 1, self()])
    send(second, {:msg, msg, m - 1})
    loop(second)
    
end

#Ultimo proceso
def start_process(0, root) do
    Process.link(root)
    loop(root)
end

#Segundo en adelante
def start_process(count, root) do
    next_pid = spawn_link(Ring, :start_process, [count-1, root])
    loop(next_pid)
end


def loop(next_pid) do
    receive do
    {:msg, msg, 0} ->
        #Process.exit(next_pid, :normal)
        send(next_pid,{:msg, msg, 0}) #Manda mensajes de más, n mensajes concretamente
    {:msg, msg, m} -> 
        send(next_pid, {:msg, msg, m - 1})
        loop(next_pid) # Reinicio por si quedan más mensajes
    end
end

end