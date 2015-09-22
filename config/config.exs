# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the namespace used by Phoenix generators
config :slerk_api,
  app_namespace: SlerkAPI

# Configures the endpoint
config :slerk_api, SlerkAPI.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "99TNO4tal/jtf0t/MwQVatTP5zLgl25in/wXo1YfkpgMNH1bMv6OIF3115qmooIG",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: SlerkAPI.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: true

# Configure Authentication
config :joken, :auth0,
  app_id: System.get_env("AUTH0_APP_ID"),
  secret: System.get_env("AUTH0_SECRET") |> Kernel.||("") |> Base.decode64 |> elem(1)
