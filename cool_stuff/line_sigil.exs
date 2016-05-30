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

defmodule FloatSigil do
  def sigil_m(lines, _opts) do
    lines 
    |> String.rstrip 
    |> String.split("\n") 
    |> Enum.map(&(&1 |> String.split(",")))
    |> Enum.map(&(check_for_float(&1)))
  end

  defp check_for_float(lines) do
    lines
    |> Enum.map(fn el ->
                  case Float.parse(el) do
                    {float, _} -> float
                    _ -> el
                  end
       end)  
  end
end

defmodule Example do
  import LineSigil
  import CommaSigil
  import FloatSigil

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

  def floatz do
    ~m"""
    1,2.22,3
    a,b,q
    """
  end
end


IO.inspect Example.lines
