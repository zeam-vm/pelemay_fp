defmodule PelemayFp.ParallelBinaryMergerTest do
  use ExUnit.Case
  doctest PelemayFp.ParallelBinaryMerger

  test "single" do
    pid = spawn(PelemayFp.ParallelBinaryMerger, :receive_insert, [self(), 1..1])
    element_1 = MergerHelper.element(1, 0)
    send(pid, element_1)

    receive do
      e -> assert e == element_1
    after
      1000 -> assert false
    end
  end

  test "10 parallel" do
    1..10
    |> Enum.map(fn i ->
      {spawn(PelemayFp.ParallelBinaryMerger, :receive_insert, [
         self(),
         1..10 |> Enum.map(&(&1 + (i - 1) * 10))
       ]), i}
    end)
    |> Enum.each(fn {pid, i} ->
      send(
        pid,
        1..10
        |> Enum.map(&MergerHelper.element(&1 + (i - 1) * 10, (&1 - 1) * 10 + (i - 1) * 100))
        |> List.flatten()
      )
    end)

    PelemayFp.ParallelBinaryMerger.receive_insert(self(), 1..100)

    receive do
      e ->
        assert e == [
                 {
                   1..100,
                   1000,
                   Enum.to_list(1..1000)
                   # Enum.reduce(1..100, [], fn _, acc -> Enum.to_list(1..10) ++ acc end)
                 }
               ]
    after
      1000 -> assert false
    end
  end

  test "10 parallel dec" do
    10..1
    |> Enum.map(fn i ->
      {spawn(PelemayFp.ParallelBinaryMerger, :receive_insert, [
         self(),
         10..1 |> Enum.map(&(&1 + (i - 1) * 10))
       ]), i}
    end)
    |> Enum.each(fn {pid, i} ->
      send(
        pid,
        10..1
        |> Enum.map(&MergerHelper.element(&1 + (i - 1) * 10, (&1 - 1) * 10 + (i - 1) * 100))
        |> List.flatten()
      )
    end)

    PelemayFp.ParallelBinaryMerger.receive_insert(self(), 100..1)

    receive do
      e ->
        assert e == [
                 {
                   1..100,
                   1000,
                   Enum.to_list(1..1000)
                 }
               ]
    after
      1000 -> assert false
    end
  end
end
