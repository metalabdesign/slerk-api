class CollectionField < GraphQL::Field
  def initialize(model:, type:)
    @model = model
    self.type = type
    self.description = "Retrieve all #{model.name.pluralize}"
    self.arguments = { }
  end

  def resolve(_, _, _)
    @model.all
  end
end
