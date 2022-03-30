defmodule ExMon.Player do
  @required_keys [:life, :moves, :name]
  @max_life 100

  @enforce_keys @required_keys
  defstruct @required_keys

  def build(name, mov_avg, move_rnd, move_heal) do
    %ExMon.Player{
      life: @max_life,
      moves: %{
        move_avg: mov_avg,
        move_heal: move_heal,
        move_rnd: move_rnd
      },
      name: name
    }
  end
end