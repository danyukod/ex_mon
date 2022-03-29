defmodule ExMon do
  alias ExMon.Player

  def create_player(name, mov_avg, move_rnd, move_heal) do
    Player.build(name, mov_avg, move_rnd, move_heal)
  end

end
