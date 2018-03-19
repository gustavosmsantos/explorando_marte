# Desafio Explorando Marte

Para a implementação, foi assumido que a sonda poderia andar apenas pelo espaço delimitado
pelo planalto. Dessa forma, uma instrução de movimento enviada nas extremidades com orientação
de modo a sair da área do planalto retorna a mesma posição.

Para flexibilização das entradas e saídas, o módulo `Processor` foi criado, de forma a admitir
diversas implementações utilizando o behaviour do `Processor.Std`. Para a execução do projeto,
basta indicar no método run() o processor para execução.

Exemplo de implementação de novo processor:

```elixir
  defmodule Processor.Csv do
    @behaviour Processor.Std

    def read_input(%{}) do
      ...
    end

    def put_output(%{}) do
      ...
    end
  end
```

O mapa recebido em ambos os métodos guardam algumas informações, como por exemplo uma chave dos blocos processados no output.

## Executando o script

Para a execução do script com input em StdIO, basta executar o comando `mix compile` seguido do comando `mix exec`.

## Testes

Para a execução da suite de testes, rodar o comando `mix test`.

### Futuras implementações
- [ ] Validação de sonda inserida em ponto fora do planalto.
- [ ] Validação de entrada do planalto
- [ ] Teste para o Processor.Std