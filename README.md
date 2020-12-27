# PelemayFp

**Pelemay Fast Pmap**: provides fast `pmap` (Parallel `map` function), similar to the `Enum` module, although computations will be executed in parallel using `Process.spawn/4`.

Here is a quick example on how to calculate the square of each element with PelemayFp:

```elixir
list
|> PelemayFp.pmap(& &1 * &1)
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `pelemay_fp` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pelemay_fp, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/pelemay_fp](https://hexdocs.pm/pelemay_fp).

