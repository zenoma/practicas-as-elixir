defmodule Sorting do

def quicksort ([]) do
    []
end

def quicksort ([pivot | tail]) do
    qsort_aux(tail, [], [], pivot)
end

defp qsort_aux([], left, right, pivot) do
   quicksort(left) ++ [pivot] ++ quicksort(right)
end

defp qsort_aux([head | tail], left, right, pivot) when (pivot >= head) do
    qsort_aux(tail, left ++ [head], right , pivot)
end

defp qsort_aux([head | tail], left, right, pivot) when (pivot < head) do
    qsort_aux(tail, left, right ++ [head] , pivot)
end


# FIXME El test no acaba la ejecución


def mergesort([h]) do
    [h]
end

def mergesort(list) do
    {left, right} = Enum.split(list,div(length(list),2))
    merge_aux(mergesort(left), mergesort(right), [])
end

defp merge_aux([], list, acc) do
    acc ++ list
end

defp merge_aux(list, [], acc) do
    acc ++ list
end

defp merge_aux([h1 | t1], [h2 | t2], acc) when h2 >= h1 do
    merge_aux(t1, [h2 | t2], acc ++ [h1])
end

defp merge_aux([h1 | t1], [h2 | t2], acc) when h1 > h2 do
    merge_aux([h1 | t1], t2, acc ++ [h2])
end

end
