defmodule SlerkAPI.UserPresence do
  @moduledoc """
  Naive implementation of user presence tracking.
  See: UserPresenceStore
  """

  alias SlerkAPI.UserPresenceStore
  alias SlerkAPI.Endpoint

  @doc "Increment count and conditionally broadcast to channel"
  def inc_ref_count(uid) do
    count = UserPresenceStore.inc_ref_count(uid)
    broadcast_status("online", uid, count)
  end

  @doc "Decrement count and conditionally broadcast to channel"
  def dec_ref_count(uid) do
    count = UserPresenceStore.dec_ref_count(uid)
    broadcast_status("offline", uid, count)
  end

  defp broadcast_status(status, uid, 1) when status == "online" do
    Endpoint.broadcast("users:presence", "status_updated", %{uid: uid, status: status})
  end

  defp broadcast_status(status, uid, 0) when status == "offline" do
    Endpoint.broadcast("users:presence", "status_updated", %{uid: uid, status: status})
  end

  defp broadcast_status(_, _, _), do: nil
end
