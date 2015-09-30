defmodule SlerkAPI.Serializer.User do
  use SlerkAPI.Serializer

  @attributes [:id, :name, :nickname, :picture, :online, :last_event_at]

  def format(record, _conn \\ %{}, _ \\ %{}) do
    record |> Map.take(@attributes)
  end
end
