defmodule SlerkAPI.UserPresence do
  @moduledoc """
  Naive implementation of user presence tracking.
  See: UserPresenceStore
  """

  alias SlerkAPI.UserPresenceStore
  alias SlerkAPI.Serializer
  alias SlerkAPI.Endpoint
  alias SlerkAPI.User

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

  @doc "Fetch presence details for given user"
  def get_presence(uid) do
    %{online:       (UserPresenceStore.get_count(uid) || 0) > 0,
      last_event_at: UserPresenceStore.get_last_event_at(uid)}
  end

  defp broadcast_status(status, uid, 1) when status == "online" do
    Endpoint.broadcast("users:presence", "status_updated", fetch_user_payload(uid))
  end

  defp broadcast_status(status, uid, 0) when status == "offline" do
    Endpoint.broadcast("users:presence", "status_updated", fetch_user_payload(uid))
  end

  defp fetch_user_payload(uid) do
    User.fetch(uid) |> Serializer.User.format
  end

  defp broadcast_status(_, _, _), do: nil
end
