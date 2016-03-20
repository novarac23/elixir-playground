defmodule Swapper do

  def swap([]) do
    []
  end
  
  def swap([a , b | tail]) do
    [b, a | tail]
  end

  def swap([_]) do
    raise "List must not have odd number of items."
  end
end
