defmodule Emprestimo_OXB.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Emprestimo_OXB.Accounts` context.
  """

  @doc """
  Generate a loan.
  """
  def loan_fixture(attrs \\ %{}) do
    {:ok, loan} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        user_id: 42
      })
      |> Emprestimo_OXB.Accounts.create_loan()

    loan
  end
end
