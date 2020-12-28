# PelemayFp

**Pelemay Fast Parallel map**: provides fast Parallel `map` function, similar to the `Enum` module, although computations will be executed in parallel using `Process.spawn/4`.

Here is a quick example on how to calculate the square of each element with PelemayFp:

```elixir
list
|> PelemayFp.map(& &1 * &1)
```

## Installation

PelemayFp supports only Elixir v1.10 and Erlang/OTP 23+, currently, due to saving our testing efforts. It can be installed by adding `pelemay_fp` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pelemay_fp, "~> 0.1.2"}
  ]
end
```

The docs can be found at [https://hexdocs.pm/pelemay_fp](https://hexdocs.pm/pelemay_fp).

## Performance

We conducted performance evaluation of PelemayFp, Pelemay, Flow, Enum and Pmap on iMac Pro (2017):

```
## PelemayFpBench
benchmark name          iterations   average time 
PelemayFp                      100   16138.54 µs/op
Pelemay                        100   18533.75 µs/op
Flow (without sorting)         100   20285.11 µs/op
PelemayFp and Pelemay          100   20741.64 µs/op
Enum                            50   31926.48 µs/op
Stream                          50   40176.14 µs/op
Flow (with sorting)             10   117144.20 µs/op
Pmap                             2   586060.00 µs/op
Task.async_stream                1   1097485.00 µs/op
```

The source code of the benchmarks is here: https://github.com/zeam-vm/pelemay_fp_benchmark


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
