defmodule Emprestimo_OXB.Repo.Migrations.CreateLoans do
  use Ecto.Migration

  def change do
    create table(:loans) do
      add :user_id, :integer
      add :emprestimo_id, :integer
      add :juros, :integer
      add :valor_emprestimo, :float
      add :valor_parcelas, :float
      add :valor_pago, :float
      add :duracao_emprestimo, :integer
      add :data_aprovacao, :integer
      add :parcelas_restantes, :integer
      timestamps()
    end
  end
end
