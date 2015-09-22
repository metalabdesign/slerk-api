defmodule SlerkAPI.Router do
  use Relax.Router, plug: :router

  plug :route
  plug :match
  plug :dispatch

  # API
  version :v1 do
    resource :channels, SlerkAPI.API.Channels
    resource :messages, SlerkAPI.API.Messages
  end

  # Help CI determine status after deploy
  get "ping", private: %{joken_skip: true} do
    send_resp(conn, 200, "pong.")
  end

  # Not found
  match _, private: %{joken_skip: true} do
    send_resp(conn, 404, "what chu talkin' bout.")
  end
end
