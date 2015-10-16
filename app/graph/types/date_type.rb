DateType = GraphQL::ScalarType.define do
  name "Date"
  description "ISO 8601 date format"
  coerce -> (value) { value.iso8601(9) }
end
