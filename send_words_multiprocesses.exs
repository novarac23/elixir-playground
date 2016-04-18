defmodule MultipleProcesses do
  def run(token1, token2) do
    pid1 = spawn(MultipleProcesses, :reply, [])
    pid2 = spawn(MultipleProcesses, :reply, [])
    send pid1, {self, token1}
    send pid2, {self, token2}

    # ensure token2 is received first, then token1
    receive do
      ^token2 -> IO.puts "Got reply: #{token2}"
    end
    receive do
      ^token1 -> IO.puts "Got reply: #{token1}"
    end
  end

  def reply do
    receive do
      {sender, token} -> send sender, token
    end
  end
end

MultipleProcesses.run("hello", "world")
