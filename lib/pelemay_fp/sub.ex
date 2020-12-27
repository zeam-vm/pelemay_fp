defmodule PelemayFp.Sub do
  @moduledoc false

  @doc false
  @spec sub_enum(pid(), Enum.t(), pos_integer(), (Enum.element() -> any())) ::
          PelemayFp.Merger.t()
  def sub_enum(pid, enumerable, id, fun) do
    send(
      pid,
      [
        {
          id..id,
          Enum.count(enumerable),
          Enum.map(enumerable, fun)
        }
      ]
    )

    exit(:normal)
  end

  @doc false
  @spec sub_chunk(pid(), Enum.t(), pos_integer(), (Enum.t() -> Enum.t())) ::
          PelemayFp.Merger.t()
  def sub_chunk(pid, enumerable, id, chunk_fun) do
    send(
      pid,
      [
        {
          id..id,
          Enum.count(enumerable),
          chunk_fun.(enumerable)
        }
      ]
    )
  end
end
