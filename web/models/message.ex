defmodule SlerkAPI.Message do
  use SlerkAPI.Web, :model

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
end
