defmodule Db do

def new() do
    Map.new()
end

#write(db_ref, key, element)
def write(map, key, element) do
    Map.put(map, key, element)
end

#delete(db_ref, key)
def delete(map, key) do
    Map.delete(map, key)
end

#read(db_ref, key)
def read(map, key) do
    case map do
      %{^key => element} -> {:ok, element}

      _ -> {:error, :not_found}
    end
end

#map = %{"a" => 1, "b" => 2, "c" => 3}
#match(db_ref, element)
def match(map, element) do
    filter(map, Map.keys(map), [], element)
end


defp filter(_, [], aux, _) do
    aux
end

defp filter(map, [head | tail], aux, element) do
    if map[head] == element do
        filter(map, tail, [head] ++ aux, element)
    else 
        filter(map, tail, aux, element)
    end
end

#destroy(db_ref)
def destroy(map) do 
    Map.drop(map, Map.keys(map))
end

end
