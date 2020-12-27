defmodule PelemayFp.ParallelBinaryMerger do
  @moduledoc """
  Receives a given consecutive list of tuples of a `Range`, count and a list,
  or an exit or dying message from the monitored process and merges it into a result,
  and send it.
  """

  @doc """
  Receives a given consecutive list of tuples of a `Range`, count and a list,
  or an exit or dying message from the monitored process and merges it into a result,
  and send it.
  """
  @spec receive_insert(pid, Range.t() | list(integer()) | PelemayFp.ParallelSplitter.t()) ::
          PelemayFp.Merger.t()
  def receive_insert(pid, from..to) do
    receive_insert(pid, Enum.to_list(from..to))
  end

  def receive_insert(pid, list) when is_list(list) do
    result = receive_insert_sub(list, [])
    send(pid, result)
  end

  defp receive_insert_sub([], result) do
    result
  end

  defp receive_insert_sub(list, result) do
    receive do
      [] ->
        receive_insert_sub(list, result)

      l = [{_from.._to, _count, _fragment} | _tail] ->
        receive_insert_sub(
          remove(list, l),
          PelemayFp.BinaryMerger.insert(result, l)
        )

      {:DOWN, _ref, :process, _pid, :normal} ->
        receive_insert_sub(list, result)
    after
      500 ->
        result
        # raise(
        #   "Timeout list = #{inspect(list, charlists: :as_lists)}, result = #{inspect(result)}"
        # )
    end
  end

  defp remove(list = [{_pid, _id} | _rest], from..to) do
    if from <= to do
      Enum.filter(list, fn {_pid, id} -> id < from or to < id end)
    else
      Enum.filter(list, fn {_pid, id} -> id < to or from < id end)
    end
  end

  defp remove(list = [{{_pid, _ref}, _id} | _rest], from..to) do
    if from <= to do
      Enum.filter(list, fn {_t, id} -> id < from or to < id end)
    else
      Enum.filter(list, fn {_t, id} -> id < to or from < id end)
    end
  end

  defp remove(list, from..to) do
    if from <= to do
      Enum.filter(list, &(&1 < from or to < &1))
    else
      Enum.filter(list, &(&1 < to or from < &1))
    end
  end

  defp remove(list, []), do: list

  defp remove(list, [{from..to, _count, _fragment} | tail]) do
    remove(list, from..to)
    |> remove(tail)
  end
end
