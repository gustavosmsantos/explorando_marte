defmodule ExplorandoMarteTest do
  use ExUnit.Case

  doctest ExplorandoMarte

  test "cenário básico" do
    planalto = %Planalto{max_x: 5, max_y: 5}
    posicao_sonda = %PosicaoSonda{x: 1, y: 3, orientacao: "N"}
    posicao_processada = ExplorandoMarte.processa_sonda(planalto, posicao_sonda, "MMRMMLLM")

    assert posicao_processada.x == 2
    assert posicao_processada.y == 5
    assert posicao_processada.orientacao == "W"
  end

  test "limite da planicie na orientação N" do
    planalto = %Planalto{max_x: 5, max_y: 5}
    posicao_sonda = %PosicaoSonda{x: 1, y: 3, orientacao: "N"}
    posicao_processada = ExplorandoMarte.processa_sonda(planalto, posicao_sonda, "MMMMMMMM")

    assert posicao_processada.x == 1
    assert posicao_processada.y == 5
    assert posicao_processada.orientacao == "N"
  end

  test "limite da planicie na orientação E" do
    planalto = %Planalto{max_x: 5, max_y: 5}
    posicao_sonda = %PosicaoSonda{x: 1, y: 3, orientacao: "E"}
    posicao_processada = ExplorandoMarte.processa_sonda(planalto, posicao_sonda, "MMMMMMMM")

    assert posicao_processada.x == 5
    assert posicao_processada.y == 3
    assert posicao_processada.orientacao == "E"
  end
  
  test "limite da planicie na orientação S" do
    planalto = %Planalto{max_x: 5, max_y: 5}
    posicao_sonda = %PosicaoSonda{x: 1, y: 3, orientacao: "S"}
    posicao_processada = ExplorandoMarte.processa_sonda(planalto, posicao_sonda, "MMMMMMMM")

    assert posicao_processada.x == 1
    assert posicao_processada.y == 0
    assert posicao_processada.orientacao == "S"
  end

  test "limite da planicie na orientação W" do
    planalto = %Planalto{max_x: 5, max_y: 5}
    posicao_sonda = %PosicaoSonda{x: 1, y: 3, orientacao: "W"}
    posicao_processada = ExplorandoMarte.processa_sonda(planalto, posicao_sonda, "MMMMMMMM")

    assert posicao_processada.x == 0
    assert posicao_processada.y == 3
    assert posicao_processada.orientacao == "W"
  end

end
