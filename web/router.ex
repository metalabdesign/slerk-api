defmodule SlerkAPI.Router do
  use Plug.Router
  import Relax.Router

  @skip_token_verification %{joken_skip: true}

  plug :relax
  plug :match
  plug :dispatch

  # API
  version :v1 do
    resource :users, SlerkAPI.API.Users
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

  # Match relax "API" routes
  def do_relax_route(conn, _), do: conn
  def relax(conn, _), do: do_relax_route(conn, conn.path_info)
end
