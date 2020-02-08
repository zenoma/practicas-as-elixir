# Compilar modulo con elixirc boolean.ex y ejecutar las funciones con Boolean.b_not(true)
defmodule Boolean do
    def b_not(true), do: false
    def b_not(false), do: true

    def b_and(true,true), do: true
    def b_and(true,false), do: false
    def b_and(false,true), do: false
    def b_and(false,false), do: false

    def b_or(true,true), do: true
    def b_or(true,false), do: true
    def b_or(false,true), do: true
    def b_or(false,false), do: false
end
