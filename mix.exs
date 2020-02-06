defmodule AprendendoElixir.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "exercicios",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [plt_add_deps: :transitive]
    ]
  end

  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:earmark, "~> 0.1", only: [:dev]},
      {:ex_doc, "~> 0.11", only: [:dev]},
      {:dialyxir, "~> 0.4", only: [:dev]},
      {:stream_data, "~>0.1", only: [:test]}
    ]
  end
end
