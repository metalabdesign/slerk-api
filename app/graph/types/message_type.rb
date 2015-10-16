MessageType = GraphQL::ObjectType.define do
  name "Message"
  description "A message in the channel"

  field :id, !types.ID
  field :text, !types.String
  field :channel, !types[!ChannelType]
end
