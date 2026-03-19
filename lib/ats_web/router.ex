defmodule AtsWeb.Router do
  use AtsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["http://localhost:5173", "http://localhost:3000"]
    plug AtsWeb.Plugs.SetCsrf
    plug AtsWeb.Api.ApiAuth
  end

  pipeline :api_authenticated do
    plug AtsWeb.Api.ApiAuth
    plug AtsWeb.Api.ApiAuth, :require_authenticated_user
  end

  # Health check endpoint
  scope "/", AtsWeb do
    get "/health", HealthController, :index
  end

  # API routes
  scope "/api", AtsWeb.Api do
    pipe_through :api

    # Public routes
    get "/jobs", JobController, :index
    get "/jobs/:id", JobController, :show
    post "/jobs/:job_id/apply", ApplyController, :create

    # Auth routes
    post "/register", UserController, :create
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/api", AtsWeb.Api do
    pipe_through [:api, :api_authenticated]

    # Authenticated routes
    get "/me", UserController, :me
    post "/jobs", JobController, :create
    put "/jobs/:id", JobController, :update
    delete "/jobs/:id", JobController, :delete
  end
end
