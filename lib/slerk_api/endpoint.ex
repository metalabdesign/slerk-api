defmodule SlerkAPI.Endpoint do
  use Phoenix.Endpoint, otp_app: :slerk_api

  socket "/socket", SlerkAPI.UserSocket

  plug Plug.RequestId
  plug Plug.Logger
  plug PlugCors
  plug Joken.Plug,
    on_verifying: &Auth0.validate/0,
    on_error: &Joken.Plug.default_on_error/2

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head
  plug SlerkAPI.Router
end
