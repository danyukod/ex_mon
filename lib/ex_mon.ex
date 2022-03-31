defmodule ExMon do
  alias ExMon.{Player, Game}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Robotinik"
  @computer_moves [:move_avg, :move_rnd, :move_heal]
  @computer_increase_moves [:move_avg, :move_rnd, :move_heal, :move_heal]

  def create_player(name, mov_avg, move_rnd, move_heal) do
    Player.build(name, mov_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    turn = Game.info()
           |> Map.get(:turn)

    case turn do
      :computer -> computer_move(Game.info())
      :player -> Status.print_round_message(Game.info())
    end
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _), do: Status.print_round_message(Game.info())
  defp handle_status(_, move) do
    move
    |> Actions.fetch_move
    |> do_move()

    computer_move(Game.info())
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)
  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, computer: %Player{ life: computer_life}})
       when computer_life <= 40 do
    move = {:ok, Enum.random(@computer_increase_moves)}
    do_move(move)
  end

  defp computer_move(%{turn: :computer, status: :started}) do
    Status.print_round_message(Game.info())

    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
  end

  defp computer_move(_), do: :ok

end
