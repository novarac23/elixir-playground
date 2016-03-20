defmodule Awesome do
  @author "Nikola Novakovic"
  def func(p1, p2 \\ 2, p3 \\ 3) do
    IO.inspect [p1, p2, p3]
  end

  def see_author(wording) do
    IO.puts "#{wording} - #{@author}"
  end
end
