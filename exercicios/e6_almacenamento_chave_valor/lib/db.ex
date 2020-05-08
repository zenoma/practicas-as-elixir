defmodule Db do
    @moduledoc"""
    Módulo Db, implementa unas funciones básicas para la manipulación de un Mapa(clave, valor)
    """
  
  
    @doc"""
    new, Devuelve un Map vacio
    """
    def new() do
        Map.new()
    end

    @doc"""
    write, Devuelve un Map en el que se añade "key" y "element"
    """
    def write(map, key, element) do
        Map.put(map, key, element)
    end

    @doc"""
    delete, Devuelve un Map en el que se elimina "key" y su correspondiente "element"
    """
    def delete(map, key) do
        Map.delete(map, key)
    end

    @doc"""
    read, Devuelve un Map en el que se visualiza el "element" correspondiente a una "key" dada
    """
    def read(map, key) do
        case map do
        %{^key => element} -> {:ok, element}

        _ -> {:error, :not_found}
        end
    end

    @doc"""
    match, Devuelve un Elemento en el que se visualiza la "key" correspondiente a un "element" dado
    """
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

    @doc"""
    destoy, Elimina todos los "key" y "element" de un Map dado
    """
    def destroy(map) do 
        Map.drop(map, Map.keys(map))
    end

end
