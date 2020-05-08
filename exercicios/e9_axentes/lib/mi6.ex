defmodule Mi6 do
    @moduledoc"""
    Módulo Mi6, Simulación de una administración de una colección de agentes especiales
    """

    #API
    @doc"""
    fundar, Construye la base de datos de los agentes especiales
    """
    def fundar() do
        GenServer.start_link(__MODULE__,[], name: :mi6)
    end

    @doc"""
    disolver, Elimina toda la colección de agentes especiales
    """
    def disolver() do 
        GenServer.stop(:mi6)
    end

    @doc"""
    recrutar, Añade un agente especial con una lista de longitud igual a la longitud del String introducido en "destino"
    """
    def recrutar(axente, destino) do 
        GenServer.cast(:mi6, {:recrutar, axente, destino})
    end

    @doc"""
    consultar_estado, Devuelve la lista asociada con el "axente" especial
    """
    def consultar_estado(axente) do 
        GenServer.call(:mi6, {:consultar, axente})
    end

    @doc"""
    asignar_mision, Modifica la lista asociada con el "axente" indicado, la "mision" puede ser :espiar o :contrainformar
    """
    def asignar_mision(axente, mision) do
        GenServer.cast(:mi6, {:asignar, axente, mision})
    end



    @impl true
    def init(db) do 
        {:ok, Db.new}
    end
    
    #Asynchronous calls
    @impl true
    def handle_cast({:recrutar, axente, destino}, db_axentes) do
        Db.read(db_axentes, axente) |> handle_recrut_aux(axente, destino, db_axentes)
    end

    @impl true
    def handle_cast({:asignar, axente, mision}, db_axentes) do
        Db.read(db_axentes, axente) |> elem(1) |> asignar(mision)
        {:noreply, db_axentes}
    end

    #Synchronous calls
    @impl true
    def handle_call({:consultar, axente}, _from, db_axentes) do
        response = Db.read(db_axentes, axente) |> elem(1) |> consultar()
        {:reply, response, db_axentes}
    end


    @impl true
    def terminate(_reason, %{}), do: :ok
    def terminate(reason, [{_, pid}|t]) do
        Agent.stop(pid)
        terminate(reason,t)
    end

    defp handle_recrut_aux({:ok,_},_,_,db_axentes), do: {:noreply, db_axentes}
    defp handle_recrut_aux({:error, :not_found}, axente, destino, db_axentes) do
        {:ok, pid} = start_link(destino)
        {:noreply, Db.write(db_axentes, axente, pid)}
    end


    # AGENT

    defp start_link(destino) do
        list = String.length(destino) |> Create.create() |> Enum.shuffle()
        Agent.start_link(fn -> list end)
    end

    defp consultar(:not_found), do: :you_are_here_we_are_not
    defp consultar(agent), do: Agent.get(agent, fn list -> list end)

    defp asignar(:not_found, _), do: :ok
    defp asignar(agent, :contrainformar), do:
        Agent.update(agent, &Manipulating.reverse/1)

    defp asignar(agent, :espiar), do:
        Agent.update(agent, &espiar/1)
    
    defp espiar([]), do: []
    defp espiar([h|t]), do: Manipulating.filter(t,h)


end
