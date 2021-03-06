defmodule ExplorandoMarte.Mixfile do
  use Mix.Project
  
  def project do
    [app: :explorando_marte,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(), aliases: aliases()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    []
  end

  defp aliases do
    [
      exec: "run -e \"Exploracao.Application.run\""
    ]
  end
end
