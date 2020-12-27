defmodule PelemayFp.BinaryMerger do
  @moduledoc """
  Inserts a given consecutive list of tuples of a `Range`, count and a list
  into another one.
  """

  @doc """
  Inserts a given consecutive list of tuples of a `Range`, count and a list
  into another one.

  ## Examples

  iex> PelemayFp.BinaryMerger.insert([{1..2, 2, [1, 2]}], [{5..6, 2, [5, 6]}])
  [{1..2, 2, [1, 2]}, {5..6, 2, [5, 6]}]

  iex> PelemayFp.BinaryMerger.insert([{1..2, 2, [1, 2]}, {5..6, 2, [5, 6]}], [{3..4, 2, [3, 4]}])
  [{1..6, 6, [1, 2, 3, 4, 5, 6]}]  

  """
  @spec insert(
          PelemayFp.Merger.t(),
          PelemayFp.Merger.t()
        ) ::
          PelemayFp.Merger.t()
  def insert([], [{from_i..to_i, count_i, fragment_i}]) do
    [{from_i..to_i, count_i, fragment_i}]
  end

  def insert(
        [head = {_from_head.._to_head, _count_head, _fragment_head} | tail],
        i = [{_from_i.._to_i, _count_i, _fragment_i}]
      ) do
    r = PelemayFp.Merger.merge([head], i)

    if Enum.count(r) > 1 do
      PelemayFp.Merger.merge(tail, i) |> PelemayFp.Merger.merge([head])
    else
      PelemayFp.Merger.merge(tail, r)
    end
  end

  def insert(
        [],
        l = [{_from_head.._to_head, _count_head, _fragment_head} | _tail]
      ) do
    l
  end

  def insert(
        list,
        [head = {_from_head.._to_head, _count_head, _fragment_head} | tail]
      ) do
    insert(list, [head])
    |> insert(tail)
  end
end
