defmodule SequenceTest do
  use ExUnit.Case
  import Sequence.Server

  setup do
    :sys.replace_state(Sequence.Server, fn {_old_state, pid} -> {Application.get_env(:sequence, :initial_number), pid} end)
    :ok
  end 

  test "next_number" do
    init_number = Application.get_env(:sequence, :initial_number)

    assert next_number == init_number
    assert next_number == init_number + 1
  end

  test "increment_number" do
    init_number = Application.get_env(:sequence, :initial_number)
    increment_number 1

    assert next_number == init_number + 1
  end
end
