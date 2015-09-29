defmodule SlerkAPI.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "channels:*", SlerkAPI.GroupChannel
  channel "users:presence", SlerkAPI.PresenceChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  # Verify and authenticate user
  def connect(params, socket) do
    token = Auth0Token.verify(params["token"])
    if token.error |> is_nil do
      {:ok, assign(socket, :uid, token.claims["sub"])}
    else
      :error
    end
  end

  # Identifier for the given socket
  def id(%{assigns: assigns}),
    do: "users_socket:" <> assigns.uid
end
