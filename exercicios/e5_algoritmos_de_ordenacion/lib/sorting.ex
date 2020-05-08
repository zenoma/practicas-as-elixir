defmodule Sorting do
    @moduledoc"""
    Módulo Sorting, implementa un par de algoritmos para la ordenación de listas
    """
  
  
    @doc"""
    quicksort, Algoritmo de ordenación basado en el QuickSort usando como pivote la cabeza de la
    """
    def quicksort ([]) do
        []
    end

    def quicksort ([pivot | tail]) do
        quicksort(tail, [], [], pivot)
    end

    defp quicksort([], left, right, pivot) do
    quicksort(left) ++ [pivot] ++ quicksort(right)
    end

    defp quicksort([head | tail], left, right, pivot) when (pivot >= head) do
        quicksort(tail, [head] ++ left, right , pivot)
    end

    defp quicksort([head | tail], left, right, pivot) when (pivot < head) do
        quicksort(tail, left, right ++ [head] , pivot)
    end

    @doc"""
    mergesort, Algoritmo de ordenación basado en el MergeSort dividiendo la lista siempre a la mitad
    """
    def mergesort([]) do
        []
    end

    def mergesort([h]) do
        [h]
    end

    def mergesort(list) do
        {left, right} = Enum.split(list,div(length(list),2))
        mergesort(mergesort(left), mergesort(right), [])
    end

    defp mergesort([], list, acc) do
        acc ++ list
    end

    defp mergesort(list, [], acc) do
        acc ++ list
    end

    defp mergesort([h1 | t1], [h2 | t2], acc) when h2 >= h1 do
        mergesort(t1, [h2 | t2], acc ++ [h1])
    end

    defp mergesort([h1 | t1], [h2 | t2], acc) when h1 > h2 do
        mergesort([h1 | t1], t2, acc ++ [h2])
    end

end