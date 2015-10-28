class FetchField < GraphQL::Field
  def initialize(model:, type:)
    @model = model
    self.type = type
    self.description = "Find a #{model.name} by ID"
    self.arguments = {
      id: GraphQL::Argument.define do
        type !GraphQL::INT_TYPE
        description "if given fetches given id"
      end
    }
  end

  def resolve(object, args, cxt)
    @model.find_by(id: args[:id])
  end
end
