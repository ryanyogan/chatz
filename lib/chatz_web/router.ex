defmodule ChatzWeb.Router do
  use ChatzWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ChatzWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", ChatzWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/", ChatzWeb do
    pipe_through [:browser, :protected]

    resources "/conversations", ConversationController
    live "/conversations/:conversation_id/users/:user_id", ConversationLive
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ChatzWeb.Telemetry
    end
  end
end
