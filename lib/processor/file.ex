defmodule Processor.File do
    @behaviour Processor.Std

    import Planalto
    import PosicaoSonda
    import BlocoSonda
    alias Utils.ReadUtils

    def read_input(_) do
        input_path = Application.get_env(:explorando_marte, :input_path)
        content = File.read!(input_path)
        [planalto_line | sonda_lines] = content |> String.split("\n")
        [max_x, max_y] = planalto_line |> ReadUtils.read_splitted()
        planalto = %Planalto{max_x: max_x, max_y: max_y}
        leitura_blocos(sonda_lines, planalto, [])
    end

    def put_output(processor_config) do
        input_path = Application.get_env(:explorando_marte, :input_path)
        linhas = processor_config.blocos |> Enum.map(&("#{&1.x} #{&1.y} #{&1.orientacao}\n"))
        
        new_path = input_path |> String.split("/") 
            |> List.insert_at(0, "output")

        unless File.exists?(new_path) do
            File.mkdir_p!(Enum.slice(new_path, 0, length(new_path) - 1) |> Enum.join("/"))
        end
        new_path |> Enum.join("/") |> File.write!(linhas)
    end

    defp leitura_blocos([posicao_line, instrucoes_line | rest], planalto, blocos) do
        [x, y, direction] = posicao_line |> ReadUtils.read_splitted()
        posicao = %PosicaoSonda{x: x, y: y, orientacao: direction}
        bloco = %BlocoSonda{planalto: planalto, posicao_inicial: posicao , instrucoes: instrucoes_line}
        leitura_blocos(rest, planalto, blocos ++ [bloco])
    end

    defp leitura_blocos([], _, blocos), do: blocos

end