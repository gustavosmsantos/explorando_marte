defmodule Exploracao.Application do

  def run(processor \\ Application.get_env(:explorando_marte, :processor)) do
      blocos_sondas = processor.read_input(%{})
      posicoes_processadas = define_sondas(blocos_sondas, [])
      processor.put_output(%{blocos: posicoes_processadas})
  end

  defp define_sondas([bloco = %BlocoSonda{} | rest], posicoes_processadas) do
    sonda_processada = ExplorandoMarte.processa_sonda(bloco.planalto, bloco.posicao_inicial, bloco.instrucoes)
    define_sondas(rest, posicoes_processadas ++ [sonda_processada])
  end

  defp define_sondas([], posicoes_processadas) do
    posicoes_processadas
  end

end
