class FetchField < GraphQL::Field
  def initialize(model:, type:)
    self.type = type
    @model = model
    self.description = "Find a #{model.name} by ID"
    self.arguments = {
      id: GraphQL::Argument.define do
        type !GraphQL::INT_TYPE
        description "if given fetches given id"
      end
    }
  end

  def resolve(object, args, cxt)
    if args["id"]
      @model.find_by(id: args["id"])
    else
      @model.all
    end
  end
end
