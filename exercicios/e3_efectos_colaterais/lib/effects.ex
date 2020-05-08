defmodule Effects do
  @moduledoc"""
  Módulo Effects, implementa un par de funciones para imprimir una secuencia de números
  """


  @doc"""
  print, Imprime por pantalla los números desde n hasta 1
  """
  def print(n) when n <= 1 do
    IO.puts(n)
  end

  def print(n) do
    print(n-1)
    IO.puts(n)
  end

  @doc"""
  print, Imprime por pantalla los números pares desde n hasta 1
  """
  def even_print(n) when n <= 2 do 
    IO.puts(n)
  end
  def even_print(n) when (n > 2 and rem(n,2) == 0) do
    even_print(n-2)
    IO.puts(n)
  end

  def even_print(n) do
    even_print(n-1)
  end


end
