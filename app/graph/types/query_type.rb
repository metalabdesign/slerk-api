QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root for this schema"

  field :me, UserType do
    resolve -> (_, _, ctx) { ctx[:current_user] }
  end

  field :user, UserType, field: FetchField.new(type: UserType, model: User)
  field :users, types[!ChannelType], field: CollectionField.new(type: UserType, model: User)

  field :channel, ChannelType, field: FetchField.new(type: ChannelType, model: Channel)
  field :channels, types[!ChannelType], field: CollectionField.new(type: ChannelType, model: Channel)

  field :message, MessageType, field: FetchField.new(type: MessageType, model: Message)
end
