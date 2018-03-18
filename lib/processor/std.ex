defmodule Processor.Std do
    
    @doc """
        Realiza a leitura do input definido
    """
    @callback read_input(processor_config :: %{}) :: [%BlocoSonda{}]
    def read_input(_) do
        [qtd_registros] = IO.gets("Defina a quantidade de sondas:\n") |> read_splitted
        [qtdX, qtdY] = IO.gets("Defina a dimensão do planalto (ex: 5 5):\n") |> read_splitted
        planalto = %Planalto{max_x: qtdX, max_y: qtdY}
        leitura_sondas(planalto, [], qtd_registros)
    end

    @doc """
        Define a saída do conteúdo processado
    """
    @callback put_output(processor_config :: %{}) :: Atom
    def put_output(processor_config) do
        processor_config.blocos |> Enum.each(&(IO.puts("#{&1.x} #{&1.y} #{&1.orientacao}")))
        :ok
    end

    defp leitura_sondas(planalto, sondas, iterator) when length(sondas) < iterator do
        num_sonda = length(sondas)
        [pos_x, pos_y, direction] = IO.gets("Defina a posição da sonda \##{num_sonda} (ex: 1 3 N):\n") |> read_splitted

        instrucoes = IO.gets("Defina as instruções da sonda \##{num_sonda} (ex: MMMLRMLM):") |> String.strip
        sonda = %PosicaoSonda{x: pos_x, y: pos_y, orientacao: direction}

        novas_sondas = sondas ++ [%BlocoSonda{planalto: planalto, posicao_inicial: sonda, instrucoes: instrucoes}]
        leitura_sondas(planalto, novas_sondas, iterator)
    end

    defp leitura_sondas(_, sondas, _), do: sondas

    defp read_splitted(input) do
        mapper = fn e ->
            case Integer.parse(e) do
                {number, ""} -> number
                :error -> e
            end
        end
        input |> String.strip |> String.split(" ") |> Enum.map(mapper)
    end
    
end