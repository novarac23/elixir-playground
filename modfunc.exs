defmodule Sum do
  def calc(0), do: 0
  def calc(n) when n > 0 do
    n + calc(n - 1)
  end
end
