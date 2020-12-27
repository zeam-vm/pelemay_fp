defmodule PelemayFp do
  @moduledoc """
  **Pelemay Fast Pmap**: provides fast `pmap` (Parallel `map` function), similar to the `Enum` module, although computations will be executed in parallel using `Process.spawn/4`.

  Here is a quick example on how to calculate the square of each element with PelemayFp:

  ```elixir
  list
  |> PelemayFp.pmap(& &1 * &1)
  ```
  """
end
