defmodule SlerkAPI.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "channels:*", SlerkAPI.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  # Verify and authenticate user
  def connect(params, socket) do
    verified_token = Auth0.verify(params.token)
    case verified_token do
      %Joken.Token{error: nil} ->
        {:ok, assign(socket, :uid, verified_token.claims["sub"])}
      :otherwise ->
        :error
    end
  end

  # Identifier for the given socket
  def id(%{assigns: assigns}),
    do: "users:" <> assigns.uid
end
