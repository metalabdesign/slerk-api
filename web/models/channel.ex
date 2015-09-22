defmodule SlerkAPI.Channel do
  use SlerkAPI.Web, :model

  schema "channels" do
    field :name,  :string
    field :topic, :string
    field :creator_id, :string

    has_many :messages, SlerkAPI.Message

    timestamps
  end

  @required_fields ~w(name creator_id)
  @optional_fields ~w(topic)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
