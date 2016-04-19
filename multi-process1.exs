defmodule MultiProc do
  import :timer, only: [sleep: 1]

  def child_process(parent_pid) do
    send parent_pid, {:ok, "Hey Ho this is a noice message!"}
    exit(:boom)
  end

  def run do
    res = spawn_link(MultiProc, :child_process, [self])
    IO.puts inspect res

    sleep 500

    receive do
      {:ok, msg} ->
        IO.puts inspect msg
    after 500 ->
      IO.puts "Looks like there is nothing more to do here."
      exit :ok
    end
  end
end

MultiProc.run
