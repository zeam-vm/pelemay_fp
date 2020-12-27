defmodule PelemayFpTest do
  use ExUnit.Case
  doctest PelemayFp

  test "PlemeayFp.map" do
    assert PelemayFp.map(1..100, &(&1 * 2), 10) == Enum.map(1..100, &(&1 * 2))
  end

  test "PlemeayFp.ma_chunk" do
    assert PelemayFp.map_chunk(1..100, &(&1 * 2), fn x -> Enum.map(x, &(&1 * 2)) end, 10) ==
             Enum.map(1..100, &(&1 * 2))
  end
end
