UserType = GraphQL::ObjectType.define do
  name "User"
  description "A user of the system"
  interfaces [NodeIdentification.interface]

  field :id, field: GraphQL::Relay::GlobalIdField.new("User")
  field :name, !types.String
  field :nickname, !types.String
  field :picture_key, !types.String
  field :online, !types.Boolean, "Whether or not the user is currently online."
  field :last_event_at, DateType
  field :created_at, DateType
  field :updated_at, DateType

  field :picture do
    type !types.String
    argument :size, !types.String, "large, medium or small."
    resolve -> (user, args, _) { UserUtils.photo_url(user, args[:size]) }
  end

  field :channels do
    type -> { !types[!ChannelType] }
    description "All channels that the user belongs to"
    resolve -> (obj, _, _) { Channel.all }
  end
end
