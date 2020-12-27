# PelemayFp

**Pelemay Fast Parallel map**: provides fast Parallel `map` function, similar to the `Enum` module, although computations will be executed in parallel using `Process.spawn/4`.

Here is a quick example on how to calculate the square of each element with PelemayFp:

```elixir
list
|> PelemayFp.map(& &1 * &1)
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

## Acknowledgement

This research is supported by Adaptable and Seamless Technology transfer
Program through Target-driven R&D (A-STEP) from Japan Science and Technology
Agency (JST) Grant Number JPMJTM20H1.

## License

Copyright 2020 Susumu Yamazaki

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
