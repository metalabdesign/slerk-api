QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root for this schema"

  field :node, field: NodeIdentification.field
  field :viewer, ViewerType do
    resolve -> (_, _, ctx) { ctx[:current_user] }
  end
end
