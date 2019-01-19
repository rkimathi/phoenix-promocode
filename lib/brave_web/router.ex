defmodule BraveWeb.Router do
  use BraveWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BraveWeb do
    pipe_through :api
  end
end
