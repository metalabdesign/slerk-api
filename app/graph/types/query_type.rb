QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root for this schema"

  field :user, UserType, field: FetchField.new(type: UserType, model: User)
  field :users do
    type types[!UserType]
    resolve -> (_, _, _) { User.all }
  end

  field :channel, ChannelType, field: FetchField.new(type: ChannelType, model: Channel)
  field :channels do
    type types[!ChannelType]
    resolve -> (_, _, _) { Channel.all }
  end

  field :message, MessageType, field: FetchField.new(type: MessageType, model: Message)
end
