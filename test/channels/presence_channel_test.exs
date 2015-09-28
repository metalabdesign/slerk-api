defmodule SlerkAPI.PresenceChannelTest do
  use SlerkAPI.ChannelCase

  alias SlerkAPI.PresenceChannel

  @topic_id "users:presence"
  @user_id "github:def456"

  setup do
    {:ok, _, socket} =
      socket("users_socket:" <> @user_id, %{uid: @user_id}) |>
      subscribe_and_join(PresenceChannel, @topic_id, %{})
    {:ok, socket: socket}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "status", %{"online" => true}
    assert_push "status", _
  end
end
