defmodule SlerkAPI.API.Channels do
  import Ecto.Query, only: [from: 1]

  use Relax.Resource

  alias SlerkAPI.Channel
  alias SlerkAPI.Repo

  def serializer, do: SlerkAPI.Serializer.Channel
  def error_serializer, do: JaSerializer.EctoErrorSerializer
  def model, do: Channel
  def repo, do: Repo

  plug :resource
  plug :not_found

  def fetchable(_) do
    from(p in Channel)
  end

  def create(conn, attributes) do
    creator_id = conn.assigns.joken_claims["sub"]
    attributes = Map.put(attributes, "creator_id", creator_id)
    Channel.changeset(%Channel{}, attributes)
  end

  def update(_, channel, attributes) do
    Channel.changeset(channel, attributes)
  end

  # NOTE: Ignore deletion for the time being.
  def delete(_, _channel) do
    # Repo.delete!(channel)
  end

  def permitted_attributes(_, _), do: [:name, :topic]
  def permitted_relations(_, _), do: [:message]
end
