MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  description "The root for mutations in this schema"

  field :newMessage, field: NewMessageMutation.field
end
