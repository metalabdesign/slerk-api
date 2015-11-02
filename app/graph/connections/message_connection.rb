MessageConnection = GraphQL::Relay::RelationConnection.create_type(MessageType) do
  field :totalCount do
    type types.Int
    resolve -> (obj, _, _) { obj.object.count }
  end
end
