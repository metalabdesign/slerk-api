defmodule SlerkAPI.GroupChannelTest do
  use SlerkAPI.ChannelCase

  alias SlerkAPI.GroupChannel

  @topic_id "channels:1c6edb3c-92a9-4031-b8b8-f194e2399db6"
  @user_id "github:def456"

  setup do
    {:ok, _, socket} =
      socket("users_socket:" <> @user_id, %{uid: @user_id}) |>
      subscribe_and_join(GroupChannel, @topic_id, %{})
    {:ok, socket: socket}
  end

  test "broadcasts messages", %{socket: socket} do
    push socket, "message", %{"text" => "wubalubadubdub"}
    assert_broadcast "message", %{id: _}, 1_500
  end

  test "sends error event on bad message payload", %{socket: socket} do
    ref = push socket, "message", %{"text" => %{}}
    assert_reply ref, :error, _
  end

  test "broadcasts typing events", %{socket: socket} do
    push socket, "typing", %{}
    assert_broadcast "user_typing", %{uid: @user_id}
  end
end
