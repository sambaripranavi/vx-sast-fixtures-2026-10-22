defmodule FixtureApp.MixProject do
  use Mix.Project

  def project do
    [app: :fixture_app, version: "0.1.0", elixir: "~> 1.17", deps: deps()]
  end

  defp deps do
    [{:phoenix, "~> 1.7.14"}, {:phoenix_ecto, "~> 4.6"}, {:ecto_sql, "~> 3.12"}, {:postgrex, ">= 0.0.0"}]
  end
end
