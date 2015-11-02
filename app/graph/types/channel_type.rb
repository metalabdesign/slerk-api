ChannelType = GraphQL::ObjectType.define do
  name "Channel"
  description "A channel in the system"
  interfaces [NodeIdentification.interface]

  field :id, field: GraphQL::Relay::GlobalIdField.new("Channel")
  field :name, !types.String
  field :topic, !types.String
  field :created_at, DateType
  field :updated_at, DateType

  field :messages do
    type -> { !types[!MessageType] }
    description "Messages in this channel"
    resolve -> (obj, _, _) { Message.where(channel_id: obj.id) }
  end

  connection :messageConnection, -> { MessageConnection } do
    resolve -> (chan, _, _) {
      Message.where(channel_id: chan)
    }
  end
end
