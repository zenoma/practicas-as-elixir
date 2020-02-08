defmodule Create do

  def create(n) when n == 0 do
    []
  end

  def create(n) when n <= 1 do
    [1]
  end

  def create (n) do
    create(n-1) ++ [n]
  end

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
