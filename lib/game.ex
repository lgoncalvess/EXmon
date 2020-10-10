defmodule ExMon.Game do
  use Agent

  def start(computer, player) do
    inital_value = %{computer: computer, player: player, turn: :player, status: :started}
    Agent.start_link(fn -> inital_value end, name: __MODULE__)
  end

  def info do
    Agent.get(__MODULE__, & &1)
  end
end
