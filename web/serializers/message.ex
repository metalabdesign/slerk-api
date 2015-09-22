defmodule SlerkAPI.Serializer.Message do
  use JaSerializer

  has_one :channel, field: :channel_id, type: "channels"
  has_one :user, field: :user_id, type: "users"
  attributes [:text, :meta, :inserted_at]
end
