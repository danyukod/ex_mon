defmodule ExMon.PlayerTest do
  use ExUnit.Case
  alias ExMon.Player

  describe "build/4" do
    test "should build a player" do
      assert %Player{
               life: 100,
               moves: %{
                 move_avg: :chute,
                 move_heal: :cura,
                 move_rnd: :soco
               },
               name: "Sonic"
             } == Player.build("Sonic", :chute, :soco, :cura)
    end
  end

end