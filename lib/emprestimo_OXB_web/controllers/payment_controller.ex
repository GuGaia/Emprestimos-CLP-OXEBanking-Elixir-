defmodule Emprestimo_OXBWeb.PaymentController do
  use Emprestimo_OXBWeb, :controller

  def index(conn, _params) do
    loans = Emprestimo_OXB.Accounts.LoanContext.get_user_loans(1610) #id do usuário
    render(conn, "parcela.html", loans: loans)
  end

  def pay_installment(conn, %{"id" => id}) do
    loan = Emprestimo_OXB.Accounts.LoanContext.get_loan!(id)
    render(conn, "pay_installment.html", loan: loan)
  end


  def pay_processing(conn, %{"id" => id, "payment_amount" => valor_pago}) do
    # Lógica para processar o pagamento e atualizar o banco de dados
    case process_payment(id, valor_pago) do
      :ok ->
        # Se o pagamento foi processado com sucesso, atualize o registro de pagamento da parcela no banco de dados
        loan = Emprestimo_OXB.Accounts.LoanContext.get_loan!(id)
        updated_installment = Emprestimo_OXB.Accounts.LoanContext.change_installment_payment(id, valor_pago)

        # Renderizar uma resposta ou redirecionar para outra página após o processamento
        render(conn, "payment_success.html", updated_installment: updated_installment)

      :error ->
        # Se houve um erro ao processar o pagamento, trate o erro ou redirecione para uma página de erro
        render(conn, "payment_error.html")
    end
  end

  defp process_payment(id, valor_pago) do
    # Lógica para se comunicar com o microserviço externo e verificar se o pagamento foi bem-sucedido
    # Supondo que você recebeu um "OK" do microserviço externo, você pode retornar :ok aqui
    :ok
  end




  defp make_payment(loan) do
    # Lógica de pagamento
    # Verifique se o pagamento pode ser processado com sucesso
    # Atualize o status da parcela ou qualquer outra ação necessária

    if payment_successful? do
      :ok
    else
      :error
    end
  end

  defp payment_successful? do
    # Simulação de pagamento bem-sucedido
    true
  end
end
