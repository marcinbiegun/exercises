defmodule MarsWater.MixProject do
  use Mix.Project

  def project do
    [
      app: :mars_water,
      version: "0.1.0",
      elixir: "~> 1.9",
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
      {:benchee, "~> 1.0", only: :dev},
      {:exprof, "~> 0.2.0", only: :dev}
    ]
  end
end
