defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(init_number) do
    result = {:ok, pid} = Supervisor.start_link(__MODULE__, [init_number])
    start_workers(pid, init_number)
    result
  end

  def start_workers(sup, init_number) do
    {:ok, stash_pid} = Supervisor.start_child(sup, worker(Sequence.Stash, [init_number]))
    Supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash_pid]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
