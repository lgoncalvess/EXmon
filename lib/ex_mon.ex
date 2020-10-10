defmodule ExMon do
  alias ExMon.{Game, Game.Actions, Game.Status, Player}

  @computer_name "Robô"

  def create_payer(name, move_rnd, move_avg, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_payer(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message()
  end

  def make_move(move) do
    Actions.fetch_move(move)
  end
end
