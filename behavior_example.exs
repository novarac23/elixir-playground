defmodule TestBehavior do
  use Behaviour
  
  defcallback crazy() :: integer
end


defmodule Test do
  @behaviour TestBehavior 

  def crazy(), do: 40
end
