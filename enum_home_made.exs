defmodule EnumHomeMade do
  def each([], _fun) do
    []
  end

  def each([head | tail], func) do
    [func.(head) | each(tail, func)]
  end

  def filter([], _func), do: []

  def filter([head | tail], func) do
    if func.(head) do
      [ head | filter(tail, func) ]
    else
      [ filter(tail, func) ]
    end
  end

  def all?([], _func), do: true

  def all?([head | tail], func) do
    if func.(head) do
      [head, filter(tail , func)]
    else
      false
    end
  end

  def split(list, count),      do: _split(list, [], count)
  defp _split([], front, _),   do: [ Enum.reverse(front), [] ]
  defp _split(tail, front, 0), do: [ Enum.reverse(front), tail ]
  defp _split([ head | tail ], front, count)  do
    _split(tail, [head|front], count-1)
  end

  def take(list, n), do: hd(split(list, n))

  def flatten([]), do: []
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
  def flatten(head), do: [ head ]
end

