defmodule SlerkAPI.ChannelTest do
  use SlerkAPI.ModelCase

  alias SlerkAPI.Channel

  @valid_attrs %{
    creator_id: "google:12345",
    topic: "Mostly Simpsons references.",
    name: "watercooler"
  }
  @invalid_attrs %{name: nil}

  test "changeset with valid attributes" do
    changeset = Channel.changeset(%Channel{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Channel.changeset(%Channel{}, @invalid_attrs)
    refute changeset.valid?
  end
end
