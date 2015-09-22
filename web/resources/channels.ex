defmodule SlerkAPI.API.Channels do
  import Ecto.Query, only: [from: 1]

  use Relax.Resource

  alias SlerkAPI.Channel
  alias SlerkAPI.Repo

  def serializer, do: SlerkAPI.Serializer.Channel
  def error_serializer, do: JaSerializer.EctoErrorSerializer
  def model, do: SlerkAPI.Models.Channel
  def repo, do: SlerkAPI.Repo

  plug :resource
  plug :not_found

  def fetchable(_) do
    from(p in Channel) |> Repo.all
  end

  def create(conn, attributes) do
    creator_id = conn.assigns.joken_claims["sub"]
    attributes = Map.put(attributes, "creator_id", creator_id)
    Channel.changeset(%Channel{}, attributes)
  end

  def update(_, channel, attributes) do
    Channel.changeset(channel, attributes)
  end

  def delete(_, channel) do
    Repo.delete!(channel)
  end

  def permitted_attributes(_, _), do: [:name, :topic]
  def permitted_relations(_, _), do: [:message]
end
