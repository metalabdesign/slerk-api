defmodule SlerkAPI.Endpoint do
  use Phoenix.Endpoint, otp_app: :slerk_api

  socket "/socket", SlerkAPI.UserSocket

  # Host documentation
  plug PlugRedirect, %{"/docs" => "/docs/v1/index.html"}
  plug Plug.Static,
    at: "/", from: :slerk_api, gzip: true,
    only: ~w(docs favicon.ico robots.txt)

  plug Plug.RequestId
  plug Plug.Logger
  plug Corsica, allow_credentials: true
  plug Joken.Plug,
    on_verifying: &Auth0Token.validate/0,
    on_error: &Joken.Plug.default_on_error/2

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head
  plug SlerkAPI.Router
end
