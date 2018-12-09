defmodule PlaygroundWeb.Router do
  use PlaygroundWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  # Public resources
  scope "/", PlaygroundWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/boards", BoardController
    resources "/columns", ColumnController
    resources "/tasks", TaskController
  end

  # Private resources
  scope "/", PlaygroundWeb do
    pipe_through :protected

    # get "/", PageController, :index
  end

  # API
  scope "/api", PlaygroundWeb do
    pipe_through :api

    resources "/boards", BoardApiController, except: [:new, :edit]
    resources "/columns", ColumnApiController, except: [:new, :edit]
    resources "/tasks", TaskApiController, except: [:new, :edit]
  end
end
