defmodule SlerkAPI.Endpoint do
  use Phoenix.Endpoint, otp_app: :slerk_api

  plug Joken.Plug,
    on_verifying: &Auth0.validate/1,
    on_error: &Joken.Plug.default_on_error/1

  socket "/socket", SlerkAPI.UserSocket

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head
  plug SlerkAPI.Router
end
