defmodule BinaryMergerTest do
  use ExUnit.Case
  doctest PelemayFp.BinaryMerger

  defp ascending do
    Enum.reduce(
      Enum.map(1..100, &MergerHelper.element(&1, 0)),
      [],
      fn x, acc -> PelemayFp.BinaryMerger.insert(acc, x) end
    )
  end

  defp descending do
    Enum.reduce(
      Enum.map(100..1, &MergerHelper.element(&1, 0)),
      [],
      fn x, acc -> PelemayFp.BinaryMerger.insert(acc, x) end
    )
  end

  defp random do
    Enum.reduce(
      1..100 |> Enum.shuffle() |> Enum.map(&MergerHelper.element(&1, 0)),
      [],
      fn x, acc -> PelemayFp.BinaryMerger.insert(acc, x) end
    )
  end

  test "equals inserting in ascending and descending order" do
    assert ascending() == descending()
  end

  test "equals inserting in ascending order and order at random" do
    assert ascending() == random()
  end
end
