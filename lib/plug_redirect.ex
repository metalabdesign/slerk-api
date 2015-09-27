defmodule PlugRedirect do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, options) do
    to = options[conn.request_path]
    do_redirect(conn, to)
  end

  defp do_redirect(conn, nil), do: conn
  defp do_redirect(conn, to) do
    conn
    |> put_resp_header("location", to)
    |> send_resp(301, "")
    |> halt
  end
end
