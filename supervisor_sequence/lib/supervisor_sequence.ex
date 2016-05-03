defmodule SupervisorSequence do
  use Application
  use Supervisor

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    {:ok, _pid} = SupervisorSequence.Supervisor.start_link(123)
  end
end
