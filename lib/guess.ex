defmodule Guess do
  use Application

  def start(_,_0) do
    run()
    {
      :ok, self()
    }
  end
  def run() do
    IO.puts("Vamos jogar")

    IO.gets("Escolha um nível de dificuldade (1, 2 ou 3): ")
    |> Integer.parse()
    |> IO.inspect()
  end
end
