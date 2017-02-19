defmodule Accounts.Mixfile do
  use Mix.Project

  def project do
    [app: :accounts,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :comeonin],
     mod: {Accounts.Application, []}]
  end

  defp deps do
    [ {:comeonin, "~> 3.0"},
      {:uuid,     "~> 1.1"},
      {:postgrex, ">= 0.0.0"},
      {:ecto,     "~> 2.1.0"},
    ]
  end
end
