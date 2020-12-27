defmodule ParallelSplitterTest do
  use ExUnit.Case
  doctest PelemayFp.ParallelSplitter

  test "single" do
    [{{pid, ref}, 0}] =
      PelemayFp.ParallelSplitter.split({SplitterHelper, :count}, self(), 0, 1..10, 10, [], [:monitor])

    receive do
      {:DOWN, ^ref, :process, ^pid, :normal} ->
        assert true

      msg ->
        IO.inspect(msg)
        assert false
    after
      1000 ->
        assert false
    end

    assert PelemayFp.ParallelSplitter.range(1..10, 10) == 0..0
  end

  test "double" do
    [{{_pid1, _ref1}, 1}, {{_pid0, _ref0}, 0}] =
      PelemayFp.ParallelSplitter.split({SplitterHelper, :count}, self(), 0, 1..20, 10, [], [:monitor])

    assert PelemayFp.ParallelSplitter.range(1..20, 10) == 1..0

    receive_single()
    receive_single()
  end

  defp receive_single() do
    receive do
      {:DOWN, _ref, :process, _pid, :normal} ->
        assert true

      msg ->
        IO.inspect(msg)
        assert false
    after
      1000 ->
        assert false
    end
  end
end
