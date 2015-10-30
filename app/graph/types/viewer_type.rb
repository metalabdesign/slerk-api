ViewerType = GraphQL::ObjectType.define do
  name "Viewer"
  description "Fields in context of the current user"

  field :user, UserType, field: FetchField.new(type: UserType, model: User)
  field :users, types[!UserType], field: CollectionField.new(type: UserType, model: User)

  field :channel, ChannelType, field: FetchField.new(type: ChannelType, model: Channel)
  field :channels, types[!ChannelType], field: CollectionField.new(type: ChannelType, model: Channel)

  field :message, MessageType, field: FetchField.new(type: MessageType, model: Message)
end
