defmodule SlerkAPI.MessageTest do
  use SlerkAPI.ModelCase

  alias SlerkAPI.Message

  @valid_attrs %{channel_id: "7488a646-e31f-11e4-aace-600308960662", meta: %{}, text: "some content", user_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Message.changeset(%Message{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Message.changeset(%Message{}, @invalid_attrs)
    refute changeset.valid?
  end
end
