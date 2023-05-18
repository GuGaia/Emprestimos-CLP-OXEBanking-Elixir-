defmodule Emprestimo_OXB.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Emprestimo_OXBWeb.Telemetry,
      # Start the Ecto repository
      Emprestimo_OXB.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Emprestimo_OXB.PubSub},
      # Start Finch
      {Finch, name: Emprestimo_OXB.Finch},
      # Start the Endpoint (http/https)
      Emprestimo_OXBWeb.Endpoint
      # Start a worker by calling: Emprestimo_OXB.Worker.start_link(arg)
      # {Emprestimo_OXB.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Emprestimo_OXB.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Emprestimo_OXBWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
