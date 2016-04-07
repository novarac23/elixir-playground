case File.open "test.txt" do
  {:ok, file } ->
    IO.puts "Yayyyy successss. First line is: #{IO.read(file, :line)}"
  { :error, reason } ->
    IO.puts "Failed to open a file: #{reason}"
end
