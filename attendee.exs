defmodule Attendee do
  defstruct name: "", paid: false, over_18: true

  def may_attend_the_party(%Attendee{name: name, paid: true}) when name != "" do
    IO.puts "HOORAY! You may attend the party: #{name}"
  end

  def may_attend_the_party(%Attendee{name: name, paid: false}) do
    IO.puts "You did not pay for the party: #{name}"
  end

  def may_attend_the_party(%Attendee{name: name}) when name == "" do
    raise "Gotta have the name bro!"
  end
end
