defmodule Tracer do
  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  defmacro def(definition = {:when, _, [nested_definition ={name, _, args}, _guard_clause]}, do: content) do
    def_impl(definition, name, args, content)
  end

  defmacro def(definition = {name, _, args}, do: content) do
    def_impl(definition, name, args, content)
  end

  defp def_impl(definition, name, args, content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "==> #{IO.ANSI.green} calling: #{Tracer.dump_defn(unquote(name), unquote(args))} #{IO.ANSI.white}"
        result = unquote(content)
        IO.puts "#{IO.ANSI.green} <<<< result: #{result}"
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end
end


defmodule Test do
  use Tracer

  def puts_sum_three(a, b, c) when is_number(a), do: IO.inspect(a+b+c)
end


Test.puts_sum_three(1,2,3)
