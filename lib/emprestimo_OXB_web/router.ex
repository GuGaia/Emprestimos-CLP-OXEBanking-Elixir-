defmodule Emprestimo_OXBWeb.Router do
  use Emprestimo_OXBWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Emprestimo_OXBWeb.Layouts, :root}
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Emprestimo_OXBWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/simulacao", EmprestimoController, :index
    post "/simular", EmprestimoController, :simular
    get "/resultado", ResultadoController, :index

  end

  # Other scopes may use custom stacks.
  # scope "/api", Emprestimo_OXBWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:emprestimo_OXB, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: Emprestimo_OXBWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
