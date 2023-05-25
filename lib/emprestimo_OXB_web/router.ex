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
    get "/users/:user_id/loans", LoanController, :get_user_loans
    get "/view_loans", PageController, :view_loans
    get "/personal", PersonalController, :index
    get "/personal/parcel_payment", PaymentController, :index
    get "/personal/parcel_payment/:id", PaymentController, :pay_installment
    post "/pay_installment", PaymentController, :pay_processing
    get "/personal/renegotiation", PersonalController, :renegotiation
    get "/personal/request_loan", PersonalController, :request_loan

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
