defmodule LineSigil do
  def sigil_l(lines, _opts) do
    lines |> String.rstrip |> String.split("\n")
  end
end
