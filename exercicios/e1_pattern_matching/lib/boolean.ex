# Compilar modulo con elixirc boolean.ex y ejecutar las funciones con Boolean.b_not(true)
defmodule Boolean do
    @moduledoc"""
    Módulo Boolean, implementa algunas operaciones básicas con Boleanos, tales como
    not, and e or
    """


    @doc"""
    b_not, Devuelve la negación del boleano dado
    """
    def b_not(true), do: false
    def b_not(false), do: true

    @doc"""
    b_and, Dado dos boleanos, devuelve el resultado de aplicar un AND lógico
    """
    def b_and(true,true), do: true
    def b_and(true,false), do: false
    def b_and(false,true), do: false
    def b_and(false,false), do: false

    @doc"""
    b_or, Dado dos boleanos, devuelve el resultado de aplicar un OR lógico
    """
    def b_or(true,true), do: true
    def b_or(true,false), do: true
    def b_or(false,true), do: true
    def b_or(false,false), do: false
end
