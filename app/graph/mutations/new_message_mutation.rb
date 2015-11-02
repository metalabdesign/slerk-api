NewMessageMutation = GraphQL::Relay::Mutation.define do
  name "NewMessage"

  input_field :text, !types.String
  input_field :channelID, !types.ID

  return_field :message, !MessageType
  return_field :channel, !ChannelType
  return_field :newMessageEdge, -> { MessageType.edge_type }

  resolve -> (args, ctx) {
    channel = NodeIdentification.object_from_id(args[:channelID]) # LOL could be anything..
    message = channel.messages.create(text: args[:text], author: ctx[:current_user])
    connection = GraphQL::Relay::RelationConnection.new(Message.all, {}) # Requires a relation(?)
    edge = GraphQL::Relay::Edge.new(message, connection)
    { message: message, channel: channel, newMessageEdge: edge }
  }
end
