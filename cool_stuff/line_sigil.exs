defmodule LineSigil do
  def sigil_l(lines, _opts) do
    lines |> String.rstrip |> String.split("\n")
  end
end

defmodule CommaSigil do
  def sigil_k(lines, _opts) do
    lines 
    |> String.rstrip 
    |> String.split("\n") 
    |> Enum.map(&(&1 |> String.split(",")))
  end
end

defmodule Example do
  import LineSigil
  import CommaSigil

  def lines do
    ~l"""
    a,b,c
    1,2,3
    """
  end

  def koma do
    ~k"""
    a,b,c
    1,2,3
    """
  end
end


IO.inspect Example.lines
