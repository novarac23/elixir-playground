defmodule Sequence.Server do
  use GenServer

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "Myyyyy current state is '#{inspect state}', and I am happy with that!"}]]
  end

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

end
