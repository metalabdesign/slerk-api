defmodule SlerkAPI.Message do
  use SlerkAPI.Web, :model

  after_insert :notify_channel

  schema "messages" do
    field :text, :string
    field :meta, :map, default: %{}
    field :user_id, :string
    belongs_to :channel, SlerkAPI.Channel

    timestamps
  end

  @required_fields ~w(text user_id channel_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  # TODO: I don't love mixing business logic into models but it's
  #   convienent for the time being.
  def notify_channel(changeset) do
    chan = "channels:" <> changeset.model.channel_id
    json = SlerkAPI.Serializer.Message.format(changeset)
    SlerkAPI.Endpoint.broadcast! chan, "message", json
  end
end
