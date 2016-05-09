defmodule SequenceTest do
  use ExUnit.Case
  import Sequence.Server

  test "next_number" do
    init_number = Application.get_env(:sequence, :initial_number)

    assert next_number == init_number
    assert next_number == init_number + 1
  end

  test "increment_number" do
    init_number = Application.get_env(:sequence, :initial_number)
    increment_number 1

    assert next_number == init_number + 3
  end
end
