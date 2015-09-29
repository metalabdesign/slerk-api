defmodule SlerkAPI.Serializers.User do
  use JaSerializer

  attributes [:name, :nickname, :picture, :online, :last_event_at]

  def id(user, _), do: user[:user_id]
end
