defmodule ExplorandoMarte do
  import Planalto
  import PosicaoSonda
  
  def processa_sonda(planalto, posicao_inicial, instrucoes) do
      processa_instrucoes(posicao_inicial, String.graphemes(instrucoes))
  end

  defp processa_instrucoes(posicao = %PosicaoSonda{}, [instrucao | rest]) do
    nova_posicao = posicao |> processa_instrucao(instrucao)
    processa_instrucoes(nova_posicao, rest)
  end

  defp processa_instrucoes(posicao, []) do
    posicao
  end

  defp processa_instrucao(posicao, "M") do
    case posicao.orientacao do
      "N" -> 
        %{posicao | y: posicao.y + 1}
      "S" -> 
        %{posicao | y: posicao.y - 1}
      "E" -> 
        %{posicao | x: posicao.x + 1}
      "W" -> 
        %{posicao | x: posicao.x - 1}
    end
  end

  defp processa_instrucao(posicao, "L") do
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

  defp processa_instrucao(posicao, "R") do
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

end
