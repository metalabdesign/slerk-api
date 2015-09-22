defmodule SlerkAPI.Serializer.Channel do
  use JaSerializer

  has_one :creator, field: :creator_id, type: "users"
  attributes [:name, :topic, :inserted_at]
end
