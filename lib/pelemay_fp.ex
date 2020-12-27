defmodule PelemayFp do
  @moduledoc """
  **Pelemay Fast Parallel map**: provides fast Parallel `map` function, 
  similar to the `Enum` module, although computations will be executed 
  in parallel using `Process.spawn/4`.

  Here is a quick example on how to calculate the square of each element with PelemayFp:

  ```elixir
  list
  |> PelemayFp.map(& &1 * &1)
  ```
  """

  @doc """
  Returns a list where each element is the result of invoking `fun` 
  on each corresponding element of `enumerable`, 
  with processing in parallel where each thread processes `threshold` elements.

  For maps, the function expects a key-value tuple.

  ## Examples

  iex> PelemayFp.map(1..3, & &1 * 2)
  [2, 4, 6]
  """
  @spec map(Enum.t(), (Enum.element() -> any()), pos_integer()) :: list()
  def map(enumerable, fun, threshold \\ 12000) do
    p_list =
      PelemayFp.ParallelSplitter.split(
        {PelemayFp.Sub, :sub_enum},
        self(),
        0,
        enumerable,
        threshold,
        fun,
        [:monitor]
      )

    [{_from.._to, _count, result}] =
      PelemayFp.ParallelBinaryMerger.receive_insert_fun(
        self(),
        p_list,
        fallback(enumerable, threshold, fun)
      )

    result
  end

  @doc """
  Returns a list where each element is the result of invoking `chunk_fun` 
  on each corresponding element of `enumerable`, 
  with processing in parallel where each thread processes a chunk of 
  `threshold` elements. When `chunk_fun` raises an error or an exception,
  it will fall back to execute `fun` instead of `chunk_fun`.

  For maps, the function expects a key-value tuple.

  ## Examples

  iex> PelemayFp.map_chunk(1..3, & &1 * 2, fn x -> Enum.map(x, & &1 * 2) end)
  [2, 4, 6]
  """
  @spec map_chunk(Enum.t(), (Enum.element() -> any()), (Enum.t() -> Enum.t()), pos_integer()) ::
          list()
  def map_chunk(enumerable, fun, chunk_fun, threshold \\ 12000) do
    p_list =
      PelemayFp.ParallelSplitter.split(
        {PelemayFp.Sub, :sub_chunk},
        self(),
        0,
        enumerable,
        threshold,
        chunk_fun,
        [:monitor]
      )

    case PelemayFp.ParallelBinaryMerger.receive_insert_fun(
           self(),
           p_list,
           fallback(enumerable, threshold, fun)
         ) do
      [{_from.._to, _count, result}] -> result
      _ -> Enum.map(enumerable, fun)
    end
  end

  @spec fallback(Enum.t(), pos_integer(), (Enum.element() -> any())) ::
          (non_neg_integer() -> list())
  defp fallback(enumerable, threshold, fun) do
    fn id ->
      enumerable
      |> Enum.slice(id * threshold, threshold)
      |> Enum.map(fun)
    end
  end
end
