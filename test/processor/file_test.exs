defmodule Processor.FileTest do

    use ExUnit.Case
    
    test "leitura de arquivo de teste, e comparação com output esperado - CT01" do

        Application.put_env(:explorando_marte, :input_path, "test/data/CT01/input.txt")
        Exploracao.Application.run(Processor.File)

        {:ok, expected_output} = File.read("test/data/CT01/output.txt")
        {:ok, returned_output} = File.read("output/test/data/CT01/input.txt")

        assert expected_output == returned_output
    end

end