defmodule My do
  defmacro if(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(else_clause)
        _ -> unquote(do_clause)
      end
    end
  end

  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    
    quote do
      if unquote(condition) do
        unquote(else_clause)
      else
        unquote(do_clause)
      end
    end
  end

  defmacro times_n(value) do
    name = :"times_#{value}"
    quote do
      def unquote(name)(x), do: unquote(value) * x 
    end
  end

  defmacro mydef(name) do
    quote bind_quoted: [name: name] do
      def unquote(name)(), do: unquote(name)
    end
  end
end

defmodule Test do
  require My

  My.if 1==2 do
    IO.puts "Expression is truthy"
  else
    IO.puts "Expressions is falsy"
  end

  My.unless 1==1 do 
    IO.puts "Inside FIRST branch"
  else
    IO.puts "Inside SECOND branch"
  end

  My.times_n(3)
  My.times_n(4)

  [:fred, :bert] |> Enum.each(&My.mydef(&1))
end
