defmodule Users do
  def check(user = %{name: user_name, state: user_state, likes: user_likes}) do
    case user do
      %{ state: some_state } = person ->
        IO.puts "#{person.name} lives in #{some_state}"

      _ ->
        IO.puts "No matches"
    end
  end
end
