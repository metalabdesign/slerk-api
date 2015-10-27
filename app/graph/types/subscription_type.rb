SubscriptionType = GraphQL::ObjectType.define do
  name "Subscription"
  description "The root for subscriptions in this schema"

  field :subscribeToMessages, !MessageType do
    description("Receive new messages. 😎")
    argument :channel_id, !types.ID
    resolve -> (o, args, ctx) {
      nil # TODO ??
    }
  end
end
