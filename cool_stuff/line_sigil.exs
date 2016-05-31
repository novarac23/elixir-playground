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

defmodule OSigil do
  def sigil_o(lines, _opts) do
    [header | rows ] =  lines
      |> String.rstrip
      |> String.split("\n")
      |> Enum.map(&(&1 |> String.split(",")))

    header = header |> Enum.map(&String.to_atom/1)

    rows
    |> Enum.map(fn col -> processCollection(col) end)
    |> Enum.map(fn row -> List.zip([header,row]) end)
  end

  defp processCollection(col), do:
    col |> Enum.map(fn element ->
                      case Integer.parse(element) do
                        {integer, ""} -> integer
                        _             -> case Float.parse(element) do
                                           {float, _} -> Float.to_string(float, [decimals: 2])
                                            _         -> element
                                      end
                      end
                    end)

end

defmodule Example do
  import LineSigil
  import CommaSigil
  import FloatSigil
  import OSigil

  def lines do
    ~l"""
    a,b,c
    1,2,3
    """
  end

  def koma do
    ~k"""
    item,qty,price
    ball,2,32
    jigsaw,1,11
    """
  end

  def floatz do
    ~m"""
    1,2.22,3
    a,b,q
    """
  end

  def kcsv do
    ~o"""
    item,qty,price
    ball,2,32
    jigsaw,1,11
    girl,1,100
    """
  end
end


IO.inspect Example.lines
