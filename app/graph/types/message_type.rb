MessageType = GraphQL::ObjectType.define do
  name "Message"
  description "A message in the channel"
  interfaces [NodeIdentification.interface]

  field :id, field: GraphQL::Relay::GlobalIdField.new("Message")
  field :text, !types.String
  field :channel, !ChannelType
end
