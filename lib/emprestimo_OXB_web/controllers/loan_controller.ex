defmodule Emprestimo_OXBWeb.LoanController do
  use Emprestimo_OXBWeb, :controller

  def get_user_loans(conn, %{"user_id" => user_id}) do
    loans = Emprestimo_OXB.Accounts.LoanContext.get_user_loans(user_id)

    render(conn, "user_loans.json", loans: loans)
  end
end
