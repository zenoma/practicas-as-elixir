defmodule Manipulating do
    @moduledoc"""
    Módulo Manipulating, implementa funciones para la manipulación básica de listas
    """
  
  
    @doc"""
    filter, Dada una lista y un critero, devuelve la lista filtrada por ese criterio
    """
    def filter([], _)do
        []
    end

    def filter([head|tail], n) when head <= n do
        [head | filter(tail,n)]
    end

    def filter([head|tail], n) when head > n do
        filter(tail,n)
    end
    
    @doc"""
    reverse, Dada una lista, devuelve la lista al revés
    """
    def reverse([]) do
        []    
    end

    def reverse(list) do
        reverse(list,[])
    end

    defp reverse([],new_list) do
        new_list
    end

    defp reverse([head | tail], new_list) do
        reverse(tail, [head | new_list])
    end

    @doc"""
    concatenate, Dado un par de listas concatena la segunda al final de la primera
    """
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

    @doc"""
    flatten, Dado un una lista de listas, concatena todas las listas internas en una lista
    """
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