MessageType = GraphQL::ObjectType.define do
  name "Message"
  description "A message in the channel"
  interfaces [NodeIdentification.interface]

  field :id, field: GraphQL::Relay::GlobalIdField.new("Message")
  field :text, !types.String
  field :created_at, !DateType
  field :updated_at, !DateType
  field :channel, !ChannelType
  field :author, !UserType
end
