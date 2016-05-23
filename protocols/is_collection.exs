defprotocol Collection do
  @fallback_to_any true
  def is_collection?(value)
end

defimpl Collection, for: [List, Tuple, BitString] do
  def is_collection?(_), do: true
end

defimpl Collection, for: Any do
  def is_collection?(_), do: false
end

Enum.each [1, 1.0, [1,2], {1,2}], fn val ->
  IO.puts "#{inspect val}: #{Collection.is_collection?(val)}"
end
