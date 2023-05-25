defmodule Emprestimo_OXB.Accounts.Loan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "loans" do

    field :user_id, :integer
    field :emprestimo_id, :integer
    field :valor_emprestimo, :float
    field :juros, :integer
    field :valor_parcelas, :float
    field :valor_pago, :float
    field :duracao_emprestimo, :integer
    field :data_aprovacao, :integer
    field :parcelas_restantes, :integer

    timestamps()
  end

  @doc false
  def changeset(loan, attrs) do
    loan
    |> cast(attrs, [:user_id, :emprestimo_id, :valor_emprestimo, :juros, :valor_parcelas,:valor_pago])
    |> validate_required([:user_id, :emprestimo_id, :valor_emprestimo, :valor_pago, :parcelas_restantes])
    |> validate_number(:valor_pago, greater_than_or_equal_to: 0)
    |> validate_number(:parcelas_restantes, greater_than_or_equal_to: 0)
  end


end
