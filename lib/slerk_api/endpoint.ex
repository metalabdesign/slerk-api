defmodule SlerkAPI.Endpoint do
  use Phoenix.Endpoint, otp_app: :slerk_api

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
