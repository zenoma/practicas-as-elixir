defmodule Echo do

def echo_fun do
    receive do 
     msg -> IO.puts(msg)
    end
     echo_fun()
end

def start do
    Process.register(spawn_link(fn -> echo_fun() end), :echo)
    :ok
end

def stop do 
    Process.exit(Process.whereis(:echo), :normal)
    Process.unregister(:echo)
    :ok
end

def print(term) do
    #send(:echo, term)
    Process.send(:echo, term, [])
end

end
