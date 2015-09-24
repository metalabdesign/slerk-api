use Mix.Config

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
config :slerk_api, SlerkAPI.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: System.get_env("HOSTNAME"), port: 443],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  check_origin: false

# Do not print debug messages in production
config :logger, level: :info

# CORS
config :plug_cors,
  origins: ["*"],
  headers: ["Authorization"]

# Configure for Heroku PostgreSQL
config :slerk_api, SlerkAPI.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  pool_size: 20
