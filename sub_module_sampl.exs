defmodule ParentModule do
  def parent_function do
    {:parent, "HELLO FROM PARENT"}
  end

  defmodule ChildModule do
    def child_function do
      {:child, "CHILD IS LITTLE"}
    end
  end
end
