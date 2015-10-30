NewMessageMutation = GraphQL::Relay::Mutation.define do
  name "NewMessage"

  input_field :text, !types.String
  input_field :channelID, !types.ID

  return_field :message, !MessageType
  return_field :channel, !ChannelType
  return_field :newChannelEdge, !types.String

  resolve -> (args, ctx) {
    ch = NodeIdentification.object_from_id("Q2hhbm5lbC0x") # LOL could be anything..
    mg = ch.messages.create(text: args[:text], author: ctx[:current_user])
    { message: mg, channel: ch, newChannelEdge: "abc" }
  }
end
