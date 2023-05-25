defmodule Emprestimo_OXB.Accounts.LoanContext do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset
  import Emprestimo_OXB.Repo

  def get_user_loans(user_id) do
    query =
      from l in Emprestimo_OXB.Accounts.Loan,
      where: l.user_id == ^user_id

    Emprestimo_OXB.Repo.all(query)
  end

  def get_loan!(emprestimo_id) do
    query =
      from l in Emprestimo_OXB.Accounts.Loan,
        where: l.emprestimo_id == ^emprestimo_id,
        select: l

    case Emprestimo_OXB.Repo.one(query) do
      nil -> raise "Loan not found"
      loan -> loan
    end
  end

  def change_installment_payment(loan_id, payment_amount) do
    case get_loan!(loan_id) do
      nil ->
        {:error, "Empréstimo não encontrado"}

      %Emprestimo_OXB.Accounts.Loan{} = loan ->
        payment_amount = String.to_integer(payment_amount)

        changeset =
          loan
          |> Ecto.Changeset.change(valor_pago: loan.valor_pago + payment_amount)
          |> Ecto.Changeset.change(parcelas_restantes: loan.parcelas_restantes - 1)

        case Emprestimo_OXB.Repo.update(changeset) do
          {:ok, updated_loan} ->
            {:ok, updated_loan}

          {:error, changeset} ->
            {:error, "Erro ao atualizar o pagamento da parcela: #{inspect(changeset.errors)}"}
        end
    end
  end

end
