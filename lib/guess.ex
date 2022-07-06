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
    |> parse_input()
    |> pickup_number()
    |> play()
  end

  def pickup_number(level) do
    level
    |> get_range()
    |> Enum.random()
  end

  @spec play(any) :: any
  def play(picked_num) do
    IO.gets('Eu ja tenho um numero, qual o seu palpite?')
    |> parse_input()
    |> guess(picked_num, 1)
  end

  def guess(usr_guess, picked_num, count) when usr_guess > picked_num do
     IO.gets("O numero que estou pensando eh menor que #{usr_guess}. Tente novamente")
     |> parse_input()
     |> guess(picked_num, count + 1)
  end

  def guess(usr_guess, picked_num, count) when usr_guess < picked_num do
    IO.gets("O numero que estou pensando eh maior que #{usr_guess}")
    |> parse_input()
    |> guess(picked_num, count + 1)
  end

  def guess(_usr_guess, picked_num, count) do
    IO.puts('Parabens, voce acertou o numero #{picked_num} em #{count} vezes' )
    show_score(count)
  end

  def parse_input(:error) do
    IO.puts('Dado invalido')
    run()
  end

  def parse_input({num, _}), do: num

  def parse_input(data) do
    data
    |> Integer.parse()
    |> parse_input()
  end

  def get_range(level) do
    case level do
      1 -> 1..10
      2 -> 1..100
      3 -> 1..1000
      _ -> IO.puts('Nivel invalido')
      run()
    end
  end

  def show_score(guesses) when guesses > 6 do
    IO.puts("Voce nao conseguiu de primeira, ne?")
  end

  def show_score(guesses) do
    {_, msg} = %{
      1..1 => "Voce leu a minha mente",
      2..4 => "Impressionante",
      3..6 => "Nada mal",
    }
    |> Enum.find(fn {range, _} ->
      Enum.member?(range, guesses)
    end)
    IO.puts(msg)
  end
end
