defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{life: 100, moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}, name: "player_test"}
      assert expected_response = ExMon.create_payer("player_test", :kick, :punch, :heal)
    end
  end

  describe "start_game/1" do
    test "when game is started, returns a message" do
      player = Player.build("player_test", :kick, :punch, :heal)
      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)
        assert messages =~ "\n====== The game is started! ======\n"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("player_test", :kick, :punch, :heal)
      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid,do the move and the computer does a move too" do
      messages =
        capture_io(fn ->
          assert ExMon.make_move(:kick) == :ok
        end)

        assert messages =~ "The player attack the computer dealing"
        assert messages =~ "status: :continue"
    end

    test "when the move is invalid,returns an error message" do
      messages =
        capture_io(fn ->
          assert ExMon.make_move(:jump) == :ok
        end)

        assert messages =~ "\n!! Invalid move jump !!\n\n"
    end
  end


end
