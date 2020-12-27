defmodule PelemayFp.ParallelSplitter do
  @moduledoc """
  Documentation for `ParallelSplitter`.
  """

  @type t :: [{pid(), non_neg_integer()} | {{pid(), reference()}, non_neg_integer()}]

  @doc """
  Returns a reversed list of tuples of a process or tuple of a process and a reference, and identity of the process 
  that spawns the given function `fun` from module `mod`, 
  passing `pid`, a list containing `threshold` elements each, `id` of the list and `arg`,
  according to the given options.

  The result depends on the given options. 
  In particular, if `:monitor` is given as an option,
  it will return list of tuples containing the PID and the monitoring reference,
  otherwise just the spawned process PID.

  It also accepts extra options, for the list of available options check `:erlang.spawn_opt/4`. 
  """
  @spec split(
          {module(), atom()},
          pid(),
          non_neg_integer(),
          Enum.t(),
          pos_integer(),
          any(),
          Process.spawn_opts()
        ) :: t()
  def split({_, _}, _, _, [], _, _, _), do: []

  def split({mod, fun}, pid, id, enumerable, threshold, arg, opts) do
    {heads, tail} = Enum.split(enumerable, threshold)

    split({mod, fun}, pid, id + 1, tail, threshold, arg, opts) ++
      [{Process.spawn(mod, fun, [pid, heads, id, arg], opts), id}]
  end

  @doc """
  """
  @spec range(Enum.t(), pos_integer()) :: Range.t()
  def range(collection, threshold) do
    div(Enum.count(collection) - 1, threshold)..0
  end
end
