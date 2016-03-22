defmodule MapKeywords do
  def weight_check(%{name: name, weight: weight}) when weight > 80 do
    IO.puts "You should go and workout #{name}"
  end

  def weight_check(%{name: name, weight: weight}) when weight < 80 do
    IO.puts "Eat a bit more mate: #{name}"
  end
end
