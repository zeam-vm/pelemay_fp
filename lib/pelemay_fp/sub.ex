defmodule PelemayFp.Sub do
  require Logger

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
  end

  @doc false
  @spec sub_chunk(
          pid(),
          Enum.t(),
          pos_integer(),
          {(Enum.t() -> Enum.t()), (non_neg_integer() -> list())}
        ) ::
          PelemayFp.Merger.t()
  def sub_chunk(pid, enumerable, id, {chunk_fun, fallback}) do
    send(
      pid,
      [
        {
          id..id,
          Enum.count(enumerable),
          try do
            chunk_fun.(enumerable)
          rescue
            _ ->
              Logger.debug("fallback #{id}")
              fallback.(id)
          catch
            _ ->
              Logger.debug("fallback #{id}")
              fallback.(id)
          end
        }
      ]
    )
  end

  @doc false
  @spec receive_result(pid) :: PelemayFp.Merger.t()
  def receive_result(pid) do
    receive do
      {:p_list, p_list} -> receive_result_sub(pid, p_list)
    end
  end

  defp receive_result_sub(pid, p_list) do
    case PelemayFp.ParallelBinaryMerger.receive_insert(self(), p_list) do
      [{_from.._to, _count, result}] -> send(pid, {:ok, result})
      _ -> send(pid, :error)
    end
  end
end
