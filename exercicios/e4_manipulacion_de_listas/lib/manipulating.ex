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

defp reverse_aux([],new_list) do
    new_list
end

defp reverse_aux([head | tail], new_list) do
    reverse_aux(tail, [head | new_list])
end

def concatenate(l) do 
    concatenate(l, [])
end

def concatenate([], new_list) do
    reverse(new_list)
end

def concatenate([[] | tail], new_list) do
    concatenate(tail, new_list)
end

def concatenate([[ih | it] |tail], new_list) do
    concatenate([it | tail], [ih | new_list])
end

# FIXME 

def flatten([]) do
    []
end

def flatten([head | tail]) do
    concatenate([flatten(head), flatten(tail)])
end

def flatten(x) do 
    [x]
end


end