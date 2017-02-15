defmodule Web.Router do
  use Web.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Web do
    pipe_through :api

    resources "/", MinderController, only: [:show, :create]
  end

  # pipeline :browser do
  #   plug :accepts, ["html"]
  #   plug :fetch_session
  #   plug :fetch_flash
  #   plug :protect_from_forgery
  #   plug :put_secure_browser_headers
  # end

  # scope "/", Web do
  #   pipe_through :browser # Use the default browser stack

  #   get "/", PageController, :index
  # end
end

