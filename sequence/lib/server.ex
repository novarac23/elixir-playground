defmodule Sequence.Server do
  use GenServer

  ### External API

  def start_link(init_value) do
    GenServer.start_link(__MODULE__, init_value, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  def pop_stack do
    GenServer.call(__MODULE__, :pop)
  end

  def push_stack(val) do
    GenServer.cast(__MODULE__, {:push, val})
  end

  ### GenServer implementation

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end
  
  def handle_call({:reset_number, new_number}, _from, _current_number) do
    {:reply, new_number, new_number}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  def handle_cast({:push, item}, list) do
    {:noreply, [item | list]}
  end

  ### Formatting status of the server response

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "Myyyyy current state is '#{inspect state}', and I am happy with that!"}]]
  end

  def terminate(reason, _state) do
    IO.puts "TERMINATE MESSAGE"
    IO.inspect reason
  end

end
