defmodule Mi6 do
    use GenServer

    @impl true
    def init(db) do 
        {:ok, db}
    end
    
    #Asynchronous calls
    @impl true
    def handle_cast({:register, new_agent}, db) do
        {:noreply, Map.merge(db,new_agent)}
    end

    @impl true
    def handle_cast({:assign_spy, agent}, db) do
        [head | _] = Map.get(db, agent)
        {:noreply, %{db | agent => Manipulating.filter(Map.get(db, agent),head)}}
    end

    @impl true
    def handle_cast({:assign_counterinform, agent}, db) do
        {:noreply, %{db | agent => Manipulating.reverse(Map.get(db, agent))}}
    end

    #Synchronous calls
    @impl true
    def handle_call({:info, axente}, _from, db) do
        case Map.get(db, axente) do 
            nil -> {:reply, :you_are_here_we_are_not, db}
            _ -> {:reply, Map.get(db, axente), db}
        end
    end

    #API

    def fundar() do
        {_reason , pid} = GenServer.start_link(Mi6, Map.new())
        Process.register(pid, :mi6)
    end

    def disolver() do 
        GenServer.stop(:mi6)
    end

    def recrutar(axente, destino) do 
        case consultar_estado(axente) do
            :you_are_here_we_are_not ->
                GenServer.cast(:mi6, {:register, %{axente => encript(destino)}})
            _ ->
            :ok
        end
    end

    def consultar_estado(axente) do 
        GenServer.call(:mi6, {:info, axente})
    end

    def asignar_mision(axente, mision) do
        case consultar_estado(axente) do
            :you_are_here_we_are_not ->
                :ok
            _ ->
            case mision do 
                :espiar ->
                    GenServer.cast(:mi6, {:assign_spy, axente})
                :contrainformar ->  
                    GenServer.cast(:mi6, {:assign_counterinform, axente})
            end
        end
    end

    #AUX FUNCTIONS
    defp encript(destino) do 
        Enum.shuffle(Create.create(String.length(destino)))
    end

end
