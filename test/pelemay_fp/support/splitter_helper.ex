defmodule SplitterHelper do
  def count(_pid, _enumerable, _id, _arg) do
    exit(:normal)
  end
end
