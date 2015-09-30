defmodule SlerkAPI.Serializer.Channel do
  use SlerkAPI.Serializer

  def format(record, _conn, _) do
    record |> Map.take([:id, :name])
  end
end
