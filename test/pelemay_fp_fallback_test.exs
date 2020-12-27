defmodule PelemayFpFallbackTest do
  use ExUnit.Case
  doctest PelemayFp

  test "fallback" do
    assert PelemayFp.map_chunk(1..11, &(&1 * 2), fn _ -> raise "error" end, 10) ==
             Enum.map(1..11, &(&1 * 2))
  end
end
