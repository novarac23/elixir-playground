defmodule WeatherHistory do

  def for_location([], location_id) do
    []
  end

  def for_location([head = [_, location_id, _, _] | tail], location_id) do
    [head | for_location(tail, location_id)]
  end

  def for_location([ _ | tail], location_id) do
    for_location(tail, location_id)
  end

end
