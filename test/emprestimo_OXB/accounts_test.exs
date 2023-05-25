defmodule Emprestimo_OXB.AccountsTest do
  use Emprestimo_OXB.DataCase

  alias Emprestimo_OXB.Accounts

  describe "loans" do
    alias Emprestimo_OXB.Accounts.Loan

    import Emprestimo_OXB.AccountsFixtures

    @invalid_attrs %{amount: nil, user_id: nil}

    test "list_loans/0 returns all loans" do
      loan = loan_fixture()
      assert Accounts.list_loans() == [loan]
    end

    test "get_loan!/1 returns the loan with given id" do
      loan = loan_fixture()
      assert Accounts.get_loan!(loan.id) == loan
    end

    test "create_loan/1 with valid data creates a loan" do
      valid_attrs = %{amount: 120.5, user_id: 42}

      assert {:ok, %Loan{} = loan} = Accounts.create_loan(valid_attrs)
      assert loan.amount == 120.5
      assert loan.user_id == 42
    end

    test "create_loan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_loan(@invalid_attrs)
    end

    test "update_loan/2 with valid data updates the loan" do
      loan = loan_fixture()
      update_attrs = %{amount: 456.7, user_id: 43}

      assert {:ok, %Loan{} = loan} = Accounts.update_loan(loan, update_attrs)
      assert loan.amount == 456.7
      assert loan.user_id == 43
    end

    test "update_loan/2 with invalid data returns error changeset" do
      loan = loan_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_loan(loan, @invalid_attrs)
      assert loan == Accounts.get_loan!(loan.id)
    end

    test "delete_loan/1 deletes the loan" do
      loan = loan_fixture()
      assert {:ok, %Loan{}} = Accounts.delete_loan(loan)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_loan!(loan.id) end
    end

    test "change_loan/1 returns a loan changeset" do
      loan = loan_fixture()
      assert %Ecto.Changeset{} = Accounts.change_loan(loan)
    end
  end
end
