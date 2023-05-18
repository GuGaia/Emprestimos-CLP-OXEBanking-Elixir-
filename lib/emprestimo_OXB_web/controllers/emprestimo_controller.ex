defmodule Emprestimo_OXBWeb.EmprestimoController do
  use Emprestimo_OXBWeb, :controller

  def index(conn, _params) do
    render(conn, "simulacao.html", assigns: conn.assigns)
  end

  @inflacao 5.6
  @taxa_SELIC 13.75


  def simular(conn, %{"valor_emprestimo" => valor_emprestimo_string, "prazo_pagamento" => prazo_pagamento_string, "renda_mensal" => renda_mensal_string}) do
    IO.inspect("Ok:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::")
    valor_emprestimo = String.to_integer(valor_emprestimo_string)
    prazo_pagamento = String.to_integer(prazo_pagamento_string)
    renda_mensal = String.to_integer(renda_mensal_string)
    taxa_juros = calcular_taxa_juros(valor_emprestimo, renda_mensal, prazo_pagamento)
    valor_parcela_mensal = calcular_valor_parcela_mensal(prazo_pagamento, valor_emprestimo, taxa_juros)
    valor_total = calcular_valor_total(valor_parcela_mensal, prazo_pagamento)

    render conn, "resultado.html", %{taxa_juros: Float.round(taxa_juros * 100, 2),
                                    valor_total: Float.round(valor_total, 2),
                                    valor_parcela_mensal: Float.round(valor_parcela_mensal, 2)}
  end

  defp calcular_taxa_juros(valor_emprestimo, renda_mensal, prazo_pagamento) do
    fator_de_risco = (renda_mensal/ valor_emprestimo)
    ((((((@taxa_SELIC + @inflacao)/12) * prazo_pagamento) / (valor_emprestimo * (0.2)))+ (1 / fator_de_risco)) / 100)
  end

  defp calcular_valor_parcela_mensal(prazo_pagamento, valor_emprestimo, taxa_juros) do

    (valor_emprestimo * taxa_juros) / (1 - :math.pow(1 + taxa_juros, prazo_pagamento * -1))

  end

  defp calcular_valor_total(valor_parcela_mensal, prazo_pagamento) do
    (valor_parcela_mensal * prazo_pagamento)
  end

end
