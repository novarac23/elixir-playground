defmodule Humanizer do
  defmacro generate(op, name, infix, suffix_addition \\ nil) do
    suffix = [name, suffix_addition] |> Enum.reject(&is_nil/1) |> Enum.join(" ")
    quote do
      def humanize({unquote(op), _, [lhs = {_, _, _}, rhs = {_, _, _}]}) do
        "first #{humanize lhs}, then #{humanize rhs}, then #{unquote(name)} both"
      end

      def humanize({unquote(op), meta, [lhs, rhs = {_, _, _}]}) do
        humanize({unquote(op), meta, [rhs, lhs]})
      end

      def humanize({unquote(op), _, [lhs = {_, _, _}, rhs]}) do
        "#{humanize lhs}, then #{unquote(suffix)} #{rhs}"
      end

      def humanize({unquote(op), _, [lhs, rhs]}) do
        "#{unquote(name)} #{lhs} #{unquote(infix)} #{rhs}"
      end
    end
  end
end

defmodule Explanations do
  require Humanizer

  Humanizer.generate :+, "add", "and"
  Humanizer.generate :+, "subtract", "from"
  Humanizer.generate :*, "multiply", "by", "by"
  Humanizer.generate :/, "divide", "by", "by"

  defmacro explain(code) do
    IO.puts humanize(code)
  end
end

defmodule Examples do
  require Explanations

  def run do
    Explanations.explain 1 + 2
    Explanations.explain 1 + 2*3
    Explanations.explain 2*3 + 1
    Explanations.explain 1*2 + 2*3
    Explanations.explain 5 * (2 + 3)
    Explanations.explain 5 * (2*2 + 3*3)
  end
end

Examples.run
