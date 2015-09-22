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

  def fetchable(_) do
    from(m in Message, limit: 300)
  end

  def filter("channel", scope, value) do
    where(scope, [m], m.channel_id == ^value)
  end

  def create(conn, attributes) do
    creator_id = conn.assigns.joken_claims["sub"]
    attributes = Map.put(attributes, "user_id", creator_id)
    Message.changeset(%Message{}, attributes)
  end

  def update(conn, message, attributes) do
    if is_owner?(conn, message) do
      Message.changeset(message, attributes)
    else
      halt send_resp(conn, 404, "resource not found")
    end
  end

  def delete(_, message) do
    Repo.delete!(message)
  end

  def permitted_attributes(_, _), do: [:text]
  def permitted_relations(_, _), do: [:channel]

  defp is_owner?(conn, message) do
    current_user_id = conn.assigns.joken_claims["sub"]
    current_user_id == message[:user_id]
  end
end
