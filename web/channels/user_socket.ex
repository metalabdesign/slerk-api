defmodule SlerkAPI.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "channels:*", SlerkAPI.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  # Verify and authenticate user
  def connect(_params, socket) do
    # TODO: 0Auth?
    {:ok, socket}
  end

  # Identifier for the given socket
  def id(%{assigns: assigns}),
    do: "users:" <> assigns.user_id
end
