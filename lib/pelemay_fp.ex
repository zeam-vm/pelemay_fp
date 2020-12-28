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
    spawn(PelemayFp.Sub, :map, [self(), enumerable, fun, threshold])

    receive do
      {:ok, result} -> result
      :error -> Enum.map(enumerable, fun)
    end
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
    spawn(PelemayFp.Sub, :map_chunk, [self(), enumerable, fun, chunk_fun, threshold])

    receive do
      {:ok, result} -> result
      :error -> Enum.map(enumerable, fun)
    end
  end
end
