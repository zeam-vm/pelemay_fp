defmodule MergerHelper do
  def element(id, offset) do
    [
      {
        id..id,
        10,
        Enum.to_list((1 + offset)..(10 + offset))
      }
    ]
  end
end
