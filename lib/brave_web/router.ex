defmodule BraveWeb.Router do
  use BraveWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BraveWeb do
    pipe_through :api
    resources "/codes", CodeController, except: [:new, :edit]
    get "/active-codes", CodeController, :active
    get "/promo-code", CodeController, :promo
  end
end
