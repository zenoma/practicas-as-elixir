defmodule Manipulating do

def filter([], _)do
    []
end

def filter([head|tail], n) when head <= n do
    [head] ++ filter(tail,n)
end

def filter([head|tail], n) when head > n do
    filter(tail,n)
end

# def reverse([]) do 
#     []
# end
# 
# def reverse([head | tail]) do
#     reverse(tail) ++ [head]
# end


#Fixme 
def reverse(list) do
    reverse_aux(list,[])    
end

defp reverse_aux([], list) do
    list
end

defp reverse_aux([head | tail], list) do
    reverse_aux([tail], list ++ head)
end


end
