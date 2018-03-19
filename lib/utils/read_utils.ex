defmodule Utils.ReadUtils do
    
    def read_splitted(input) do
        mapper = fn e ->
            case Integer.parse(e) do
                {number, ""} -> number
                :error -> e
            end
        end
        input |> String.strip |> String.split(" ") |> Enum.map(mapper)
    end

end