defmodule SpawnBasic do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello m8 and #{msg}"}
        greet
    end
  end
end

pid = spawn(SpawnBasic, :greet, [])
send pid, {self, "World"}

receive do
  {:ok, msg} ->
    IO.puts msg
end

pid = spawn(SpawnBasic, :greet, [])
send pid, {self, "Voldemort"}

receive do
  {:ok, msg} ->
    IO.puts msg
  after 500 ->
    IO.puts "The greeter has left"
end
