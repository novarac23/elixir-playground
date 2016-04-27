defmodule RingTicker do
  @interval 2000
  @name :ticker

  def start do
    spawn __MODULE__, :ticker, []
  end

  def add_client do
    pid = spawn __MODULE__, :receiver, []
    register pid
  end

  def ticker(next_client \\ self) do
    :global.register_name(@name, self)
    
    receive do
      {:register, new_client} ->
        IO.puts "registering #{inspect new_client}"
        send new_client, {:tick, next_client}
        receiver(new_client)
      after @interval ->
        IO.puts "tick"
        send next_client, {:tick}
        receiver(next_client)
    end
  end

  def receiver(next_client \\ self) do
    receive do
      {:tick, new_client} ->
        IO.puts "first tock in #{inspect self}, sending a tick to #{inspect new_client} in 2s"
        ticker(new_client)
      {:tick} ->
        IO.puts "tock in #{inspect self}, sending a tick to #{inspect next_client} in 2s"
        ticker(next_client)
    end
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end
end
