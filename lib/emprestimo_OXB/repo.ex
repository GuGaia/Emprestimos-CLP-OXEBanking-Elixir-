defmodule Emprestimo_OXB.Repo do
  use Ecto.Repo,
    otp_app: :emprestimo_OXB,
    adapter: Ecto.Adapters.Postgres
end
