defmodule NikList do

  def len([]) do
   0
  end 

  def len([_head | tail]) do
   1 + len(tail)
  end

  def square([]) do
   []
  end

  def square([head | tail]) do
   [ head*head | square(tail) ]
  end

  def map([], _func) do
    []
  end
  
  def map([head | tail], func) do
    [func.(head) | map(tail, func)]
  end

  def sum(list) do
    _sum(list, 0)
  end

  defp _sum([], total) do
    total
  end

  defp _sum([head | tail], total) do
    _sum(tail, total + head)
    # or head + sum(tail)
  end

  def reduce([], value, _) do
    value
  end

  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def mapsum([], _func) do
    0
  end

  def mapsum([head | tail], func) do
    func.(head) + mapsum(tail, func)
  end

  def max([x]) do
    x 
  end
  
  def max([head | tail]) do
    Kernel.max(head, max(tail))
  end
end
