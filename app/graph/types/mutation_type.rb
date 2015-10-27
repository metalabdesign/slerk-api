MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  description "The root for mutations in this schema"

  field :newMessage, !MessageType do
    description("Create a new message in the given channel. 😎")
    argument :text, !types.String
    argument :channel_id, !types.ID
    resolve -> (o, args, ctx) {
      ch = Channel.find(args[:channel_id])
      ch.messages.create(text: args[:text])
    }
  end
end
