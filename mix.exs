defmodule SlerkAPI.Mixfile do
  use Mix.Project

  def project do
    [app: :slerk_api,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {SlerkAPI, []},
     applications: [:phoenix, :cowboy, :logger, :phoenix_ecto, :postgrex, :httpotion, :con_cache]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.0.2"},
     {:phoenix_ecto, "~> 1.1"},
     {:postgrex, ">= 0.0.0"},
     {:cowboy, "~> 1.0"},
     {:joken, "0.16.0"},
     {:relax, github: "AgilionApps/relax"},
     {:plug_cors, "~> 0.8.0"},
     {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.2"},
     {:httpotion, "~> 2.1.0"},
     {:inflex, "~> 1.5.0"},
     {:con_cache, "~> 0.9.0"}]
  end
end
