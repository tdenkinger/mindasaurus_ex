defmodule Web.Router do
  use Web.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Web do
    pipe_through :api

    resources "/reminder", MinderController,  only: [:show, :create]
    resources "/account",  AccountController, only: [:show, :create]
  end
end

