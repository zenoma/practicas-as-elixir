defmodule Manipulating do

def filter([], _)do
    []
end

def filter([head|tail], n) when head <= n do
    [head | filter(tail,n)]
end

def filter([head|tail], n) when head > n do
    filter(tail,n)
end
 
def reverse([]) do
    []    
end

def reverse(list) do
    reverse_aux(list,[])
end

defp reverse_aux([head | tail], new_list) do
    reverse_aux(tail, [head | new_list])
end

defp reverse_aux([],new_list) do
    new_list
end

def concatenate ([]) do
    []
end

def concatenate (list) do
    concatenate_aux(list,[])
end

defp concatenate_aux([], aux) do
    reverse(aux)
end

defp concatenate_aux([[]| tail], aux) do 
    concatenate_aux(tail, aux)
end

defp concatenate_aux([[head | tail] | tail1],aux) do
    concatenate_aux([ tail | tail1 ], [head | aux])
end

# FIXME 

def flatten([]) do
    []
end

def flatten([head | tail]) do
    concatenate([flatten([head]), flatten([tail])])
end

def flatten(x) do 
    x
end


end