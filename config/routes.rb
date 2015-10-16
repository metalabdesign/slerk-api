Rails.application.routes.draw do
  post "/graphql", to: "queries#query"
end
