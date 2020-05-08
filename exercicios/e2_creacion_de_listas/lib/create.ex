defmodule Create do
  @moduledoc"""
  Módulo Create, implementa algunas opreaciones básicas de creación de listas, 
  tales como crear o crear inversamente.
  """


  @doc"""
  create, Devuelve una lista con n elementos ordenados de 1 a n
  """
  def create(n) when n == 0 do
    []
  end

  def create(n) when n <= 1 do
    [1]
  end

  def create (n) do
    create(n-1) ++ [n]
  end

  @doc"""
  reverse_create, Devuelve una lista con n elementos ordenados de n a 1
  """
  def reverse_create(n) when n == 0 do
    []
  end

  def reverse_create(n) when n <= 1  do
    [1]
  end

  def reverse_create(n) do
    [n] ++ reverse_create(n - 1)
  end

end
