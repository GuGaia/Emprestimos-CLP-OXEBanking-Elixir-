defmodule Emprestimo_OXBWeb.ErrorJSONTest do
  use Emprestimo_OXBWeb.ConnCase, async: true

  test "renders 404" do
    assert Emprestimo_OXBWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Emprestimo_OXBWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
