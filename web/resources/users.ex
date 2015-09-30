defmodule SlerkAPI.API.Users do
  use Plug.Builder

  import Relax.Responders

  alias SlerkAPI.User
  alias SlerkAPI.Serializer

  plug JaSerializer.ContentTypeNegotiation

  def serializer, do: Serializer.User

  def call(conn, _) do
    conn = Plug.Conn.put_resp_header(conn, "content-type", "application/vnd.api+json")
    path_info = conn.path_info |> Enum.map(&URI.decode/1)
    do_resource(conn, conn.method, path_info)
  end

  ## GET users/:id
  def do_resource(conn, "GET", [id]) do
    fetch_one_resource(id) |> do_resp(conn)
  end

  ## Pass on everything else
  def do_resource(conn, _), do: conn

  ## Fetch user
  def fetch_one_resource(id), do: User.fetch(id)

  ## Response
  def do_resp(%{error: _}, conn), do: not_found(conn)
  def do_resp(record, conn), do: okay(conn, record)
end
