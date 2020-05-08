defmodule Echo do
    @moduledoc"""
    Módulo Echo, Implementa un Servidor Echo sencillo
    """
  
  
    defp echo_fun do
        receive do 
        msg -> IO.puts(msg)
        end
        echo_fun()
    end

    @doc"""
    start, Comienza el servidor Echo
    """
    def start do
        Process.register(spawn_link(fn -> echo_fun() end), :echo)
        :ok
    end

    @doc"""
    stop, Para el servidor Echo
    """
    def stop do 
        Process.exit(Process.whereis(:echo), :normal)
        Process.unregister(:echo)
        :ok
    end

    @doc"""
    print, Envía un mensaje al Servidor Echo
    """
    def print(term) do
        Process.send(:echo, term, [])
    end

end
