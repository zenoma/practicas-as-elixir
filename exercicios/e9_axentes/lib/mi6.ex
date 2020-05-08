defmodule Mi6 do

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

    #API

    def fundar() do
        GenServer.start_link(__MODULE__,[], name: :mi6)
    end

    def disolver() do 
        GenServer.stop(:mi6)
    end

    def recrutar(axente, destino) do 
        GenServer.cast(:mi6, {:recrutar, axente, destino})
    end

    def consultar_estado(axente) do 
        GenServer.call(:mi6, {:consultar, axente})
    end

    def asignar_mision(axente, mision) do
        GenServer.cast(:mi6, {:asignar, axente, mision})
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
