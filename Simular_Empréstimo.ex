defmodule Emprestimo do
  @inflacao 5.6
  @taxa_SELIC 13.75

  def simular(valor_empréstimo, prazo_pagamento, renda_mensal) do
    taxa_juros = calcular_taxa_juros(valor_empréstimo, renda_mensal, prazo_pagamento)
    valor_parcela_mensal = calcular_valor_parcela_mensal(prazo_pagamento, valor_empréstimo, taxa_juros)
    valor_total = calcular_valor_total(valor_parcela_mensal, prazo_pagamento)
    IO.puts("taxa_juros: #{Float.round(taxa_juros * 100, 2)}%\nvalor_total: #{Float.round(valor_total, 2)}\nvalor_parcela_mensal: #{Float.round(valor_parcela_mensal, 2)}\n")
  end

  defp calcular_taxa_juros(valor_empréstimo, renda_mensal, prazo_pagamento) do
    fator_de_risco = (renda_mensal/ valor_empréstimo)
    ((((((@taxa_SELIC + @inflacao)/12) * prazo_pagamento) / (valor_empréstimo * (0.2)))+ (1 / fator_de_risco)) / 100)
  end

  defp calcular_valor_parcela_mensal(prazo_pagamento, valor_empréstimo, taxa_juros) do

    (valor_empréstimo * taxa_juros) / (1 - :math.pow(1 + taxa_juros, prazo_pagamento * -1))

  end

  defp calcular_valor_total(valor_parcela_mensal, prazo_pagamento) do
    (valor_parcela_mensal * prazo_pagamento)
  end

end
