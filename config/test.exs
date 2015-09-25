use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :slerk_api, SlerkAPI.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Set a higher stacktrace during test
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :slerk_api, SlerkAPI.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  database: "slerk_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
