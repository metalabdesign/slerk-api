defmodule SlerkAPI.API.Messages do
  import Ecto.Query, only: [from: 2, where: 3]

  use Relax.Resource

  alias SlerkAPI.Message
  alias SlerkAPI.Repo

  def serializer, do: SlerkAPI.Serializer.Message
  def error_serializer, do: JaSerializer.EctoErrorSerializer
  def model, do: SlerkAPI.Models.Message
  def repo, do: SlerkAPI.Repo

  plug :resource
  plug :not_found

  # Matches /channels/:parent_id/messages
  def fetchable(%{private: %{relax_parent_id: channel_id}}) do
    message_scope |> where([m], m.channel_id == ^channel_id)
  end

  def fetchable(_) do
    message_scope
  end

  def filter("channel", scope, value) do
    where(scope, [m], m.channel_id == ^value)
  end

  def create(conn, attributes) do
    Message.changeset(%Message{}, attributes
      |> Map.put("user_id", conn.assigns.joken_claims["sub"])
      |> put_if_nil("channel_id", conn.private[:relax_parent_id]))
  end

  def update(conn, message, attributes) do
    if is_owner?(conn, message) do
      Message.changeset(message, Dict.take(attributes, ["text"]))
    else
      halt send_resp(conn, 404, "resource not found")
    end
  end

  def delete(_, message) do
    Repo.delete!(message)
  end

  def permitted_attributes(_, _), do: [:text]
  def permitted_relations(_, _), do: [:channel]

  defp message_scope do
    from(m in Message, limit: 300, preload: :channel)
  end

  defp is_owner?(conn, message) do
    current_user_id = conn.assigns.joken_claims["sub"]
    current_user_id == Map.get(message, :user_id)
  end

  defp put_if_nil(map, key, val) do
    case map[key] do
      nil -> Map.put(map, key, val)
      :otherwise -> Map.put_new(map, key, val)
    end
  end
end
