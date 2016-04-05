defmodule MyString do

  def center(strings) do
    strings 
    |> Enum.map_reduce(0, accumulate_max_length(&1, &2))
    |> center_strings_in_field
    |> Enum.each(IO.puts(&1))
  end

  # We jump through this hoop to avoid calculating the string length twice.
  # Here, we build a tuple containing the length and the string, and
  # nest it in a tuple containing the maximum length seen so far
  defp accumulate_max_length(string, max_length_so_far) do
    l = String.length(string)
    { {string, l}, max(l, max_length_so_far) }
  end

  defp center_strings_in_field({strings, field_width}) do
    strings |> Enum.map(center_one_string(field_width, &1))
  end

  defp center_one_string(field_width, {string, length}) do
    %b[#{String.duplicate(" ", div(field_width - length, 2))}#{string}]
  end
end
