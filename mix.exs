defmodule PelemayFp.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :pelemay_fp,
      version: @version,
      elixir: "~> 1.11",
      package: package(),
      description: "Fast parallel map function for Elixir",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp package do
    %{
      licenses: ["Apache 2"],
      maintainers: ["Susumu Yamazaki"],
      links: %{"GitHub" => "https://github.com/zeam-vm/pelemay_fp"}
    }
  end
end
