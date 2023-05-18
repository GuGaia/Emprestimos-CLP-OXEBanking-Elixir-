defmodule Emprestimo_OXBWeb.ResultadoController do
  use Emprestimo_OXBWeb, :controller

  def index(conn, _params) do
    render(conn, "resultado.html", assigns: conn.assigns)
  end
end
