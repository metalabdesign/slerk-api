ChannelType = GraphQL::ObjectType.define do
  name "Channel"
  description "A channel in the system"

  field :id, !types.ID
  field :name, !types.String
  field :topic, !types.String
  field :created_at, DateType
  field :updated_at, DateType

  field :messages do
    type -> { !types[!MessageType] }
    description "Messages in this channel"
    resolve -> (obj, _, _) { Message.where(channel_id: obj.id) }
  end
end
