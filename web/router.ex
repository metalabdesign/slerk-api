defmodule SlerkAPI.Router do
  use SlerkAPI.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SlerkAPI do
    pipe_through :api
    # resources: users, channels, etc.
  end
end
