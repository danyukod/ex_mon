defmodule ExMon.Game.ActionsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Player, Game}
  alias ExMon.Game.Actions

  describe "fetch_move/1" do
    test "should return a move" do
      player = Player.build("Sonic", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)
      assert {:ok, :move_rnd} == Actions.fetch_move(:soco)
    end
  end

  describe "attack/1" do
    test "when the player's turn, the attack must affect the computer,
          and when the computer's turn , the attack must affect the player" do
      player = Player.build("Sonic", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      message = capture_io(
        fn ->
          Actions.attack(:move_rnd)
          Actions.attack(:move_rnd)
        end
      )

      assert message =~ "The Player attacked the computer dealing:"
      assert message =~ "The Computer attacked the Player dealing:"
    end
  end

  describe "heal/1" do
    test "when the player's turn, the heal must affect the player,
          and when the computer's turn , the heal must affect the computer" do
      player = Player.build("Sonic", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)
      Game.start(computer, player)

      message = capture_io(
        fn ->
          Actions.heal()
          Actions.heal()
        end
      )

      assert message =~ "The player healed itself to 100 life points."
      assert message =~ "The computer hplayerealed itself to 100 life points."
    end
  end

end