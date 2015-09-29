defmodule SlerkAPI.Serializers.User do
  use JaSerializer

  attributes [:name, :nickname, :blog, :picture, :online, :last_event_at]

  def id(user, _), do: user[:user_id]
end
