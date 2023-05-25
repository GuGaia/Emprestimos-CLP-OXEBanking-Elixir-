defmodule Emprestimo_OXBWeb.PageController do
  use Emprestimo_OXBWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)

  end

  def view_loans(conn, _params) do
    user_id = 1610  # Substitua pelo ID do usuário que você deseja recuperar os empréstimos
    loans = Emprestimo_OXB.Accounts.LoanContext.get_user_loans(user_id)
    render(conn, "loans.html", loans: loans)
  end

end
