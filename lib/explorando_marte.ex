defmodule ExplorandoMarte do
  
  @doc """
    Processa a nova posição de uma sonda dentro do planalto, após a execução das instruções
  """
  @callback processa_sonda(planalto :: %Planalto{}, posicao_inicial :: %PosicaoSonda{}, instrucoes :: String) :: %PosicaoSonda{}
  def processa_sonda(planalto, posicao_inicial, instrucoes) do
      processa_instrucoes(posicao_inicial, planalto, String.graphemes(instrucoes))
  end

  defp processa_instrucoes(posicao = %PosicaoSonda{}, planalto = %Planalto{}, [instrucao | rest]) do
    posicao |> processa_instrucao(planalto, instrucao) |> processa_instrucoes(planalto, rest)
  end

  defp processa_instrucoes(posicao, _, []) do
    posicao
  end

  defp processa_instrucao(posicao, planalto, "M") do
    funIncremento = {&(&1 > &2), &(&1 + 1)}
    funDecremento = {&(&1 < &2), &(&1 - 1)}

    case posicao.orientacao do
      "N" -> 
        %{posicao | y: calcula_nova_posicao(planalto.max_y, posicao.y, funIncremento)}
      "S" -> 
        %{posicao | y: calcula_nova_posicao(planalto.min_y, posicao.y, funDecremento)}
      "E" -> 
        %{posicao | x: calcula_nova_posicao(planalto.max_x, posicao.x, funIncremento)}
      "W" -> 
        %{posicao | x: calcula_nova_posicao(planalto.min_x, posicao.x, funDecremento)}
    end
  end

  defp processa_instrucao(posicao, _, "L") do
    case posicao.orientacao do
      "N" -> 
        %{posicao | orientacao: "W"}
      "S" -> 
        %{posicao | orientacao: "E"}
      "E" -> 
        %{posicao | orientacao: "N"}
      "W" -> 
        %{posicao | orientacao: "S"}
    end
  end

  defp processa_instrucao(posicao, _, "R") do
    case posicao.orientacao do
      "N" -> 
        %{posicao | orientacao: "E"}
      "S" -> 
        %{posicao | orientacao: "W"}
      "E" -> 
        %{posicao | orientacao: "S"}
      "W" -> 
        %{posicao | orientacao: "N"}
    end
  end

  defp calcula_nova_posicao(limite_posicao, posicao_atual, {funComp, funNext}) do
    if funComp.(funNext.(posicao_atual), limite_posicao) do
      posicao_atual
    else
      funNext.(posicao_atual)
    end
  end

end
