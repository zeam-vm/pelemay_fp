defmodule PelemayFp.MixProject do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      app: :pelemay_fp,
      version: @version,
      elixir: "~> 1.11",
      package: package(),
      description: "Fast parallel map function for Elixir",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [plt_add_deps: :transitive],
      elixirc_paths: elixirc_paths(Mix.env()),

      # Docs
      name: "PelemayFp",
      docs: [
        main: "PelemayFp",
        source_url: "https://github.com/zeam-vm/pelemay_fp",
        source_ref: "v#{@version}",
        logo: "logo/Pelemay.png",
        extras: ["README.md"]
      ]
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
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:git_hooks, "~> 0.5.1", only: [:test, :dev], runtime: false},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false}
    ]
  end

  defp package do
    %{
      licenses: ["Apache 2"],
      maintainers: ["Susumu Yamazaki"],
      links: %{"GitHub" => "https://github.com/zeam-vm/pelemay_fp"}
    }
  end

  defp elixirc_paths(:test), do: ["lib", "test/pelemay_fp/support"]
  defp elixirc_paths(_), do: ["lib"]
end
