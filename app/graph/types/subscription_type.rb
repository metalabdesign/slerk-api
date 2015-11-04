SubscriptionType = GraphQL::ObjectType.define do
  name "Subscription"
  description "The root for subscriptions in this schema"

  field :newMessage, !MessageType do
    description("Receive new messages.😎")
    argument :channelID, !types.ID
    resolve -> (o, args, ctx) {
      nil # TODO ??
    }
  end
end
