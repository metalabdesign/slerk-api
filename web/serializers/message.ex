defmodule SlerkAPI.Serializer.Message do
  use SlerkAPI.Serializer

  import SlerkAPI.Message, only: [preload: 2]

  def format(record, _, _) when is_map(record) do
    record
    |> preload(:channel)
    |> preload(:user)
    |> serialize(:channel)
    |> serialize(:user)
    |> Map.take([:id, :text, :meta, :user, :channel])
  end

  def serializer(:channel), do: SlerkAPI.Serializer.Channel
  def serializer(:user), do: SlerkAPI.Serializer.User

  def serialize(record, key) do
    association = Map.get(record, key)
    association = association && serializer(key).format(association)
    Map.put(record, key, association)
  end
end
