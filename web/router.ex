defmodule SlerkAPI.Router do
  use Relax.Router, plug: :router

  @skip_token_verification %{joken_skip: true}

  plug :route
  plug :match
  plug :dispatch

  # API
  version :v1 do
    resource :messages, SlerkAPI.API.Messages
    resource :channels, SlerkAPI.API.Channels do
      resource :messages, SlerkAPI.API.Messages
    end
  end

  # Help CI determine status after deploy
  get "ping", private: @skip_token_verification do
    send_resp(conn, 200, "pong.")
  end

  # Not found
  match _, private: @skip_token_verification do
    send_resp(conn, 404, "what chu talkin' bout.")
  end
end
