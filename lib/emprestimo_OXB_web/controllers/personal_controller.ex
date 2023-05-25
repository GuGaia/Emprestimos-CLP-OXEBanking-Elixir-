defmodule Emprestimo_OXBWeb.PersonalController do
  use Emprestimo_OXBWeb, :controller

  def index(conn, _params) do
    render(conn, "personal.html", assigns: conn.assigns)
  end

  def parcel_payment(conn, %{"emprestimo_id" => emprestimo_id}) do
    loan = Emprestimo_OXB.Accounts.LoanContext.get_loan!(emprestimo_id)

    # Lógica de pagamento da parcela do empréstimo
    # Por exemplo, atualizar o status da parcela ou calcular o novo saldo

    # Redirecionar para a página de sucesso após o pagamento
    redirect(conn, to: Routes.personal_loan_path(conn, :payment_success))
  end

  def payment_success(conn, _params) do
    render(conn, "payment_success.html")
  end

  def renegotiation(conn, _params) do
    # Lógica para renegociação de empréstimo
    render(conn, "renegotiation.html")
  end

  def request_loan(conn, _params) do
    # Lógica para solicitação de empréstimo
    render(conn, "request_loan.html")
  end

end
