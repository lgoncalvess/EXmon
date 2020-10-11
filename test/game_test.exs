defmodule ExMon.GameTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("player_test", :kick, :punch, :heal)
      computer = Player.build("computer_test", :kick, :punch, :heal)
      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "return the current game state" do
      player = Player.build("player_test", :kick, :punch, :heal)
      computer = Player.build("computer_test", :kick, :punch, :heal)
      Game.start(computer, player)

      expected_response = %{computer: %Player{life: 100, moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}, name: "computer_test"}, player: %Player{life: 100, moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}, name: "player_test"}, status: :started, turn: :player}

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "return the game state updated" do
      player = Player.build("player_test", :kick, :punch, :heal)
      computer = Player.build("computer_test", :kick, :punch, :heal)
      Game.start(computer, player)

      expected_response = %{computer: %Player{life: 100, moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}, name: "computer_test"}, player: %Player{life: 100, moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}, name: "player_test"}, status: :started, turn: :player}
      assert Game.info() == expected_response

      updated_response = %{computer: %Player{life: 50, moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}, name: "computer_test"}, player: %Player{life: 20, moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}, name: "player_test"}, status: :started, turn: :player}
      update_status = %{updated_response | status: :continue, turn: :computer}
      Game.update(updated_response)
      assert Game.info() == update_status
    end
  end
end
