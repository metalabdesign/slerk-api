defmodule SlerkAPI.API.Users do
  use Plug.Builder

  import Relax.Responders

  alias SlerkAPI.Serializers
  alias SlerkAPI.UserPresence

  plug JaSerializer.ContentTypeNegotiation

  def serializer, do: Serializers.User

  def call(conn, _) do
    conn = Plug.Conn.put_resp_header(conn, "content-type", "application/vnd.api+json")
    path_info = conn.path_info |> Enum.map(&URI.decode/1)
    do_resource(conn, conn.method, path_info)
  end

  ## GET users/:id
  def do_resource(conn, "GET", [id]) do
    record = fetch_one_resource(id)
    if is_nil(record[:error]), do: okay(conn, record), else: not_found(conn)
  end

  ## Pass on everything else
  def do_resource(conn, _), do: conn

  ## Fetch user details from Auth0 & user presence store in parallel
  def fetch_one_resource(id) do
    [ Task.async(fn -> Auth0.get_user(id).body end),
      Task.async(UserPresence, :get_presence, [id]) ]
    |> Enum.map(&Task.await(&1, 5_000))
    |> Enum.concat |> Enum.into(%{})
  end
end
