defmodule TestBehavior do
  use Behaviour
  
  defcallback say_hello(String.t) :: any
end


defmodule Test do
  @behaviour TestBehavior 

  def say_hello(param) do
    IO.puts param
  end
end

Test.say_hello "nik"
Test.say_hello 2
