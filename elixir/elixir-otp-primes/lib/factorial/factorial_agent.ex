defmodule Factorial.GenServer do
  use GenServer
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def loop(state) do
    receive do
      {:add, name} ->
        new_state = state ++ [name]
        loop(new_state)
      {:remove, name} ->
        new_state = state |> Enum.filter(& &1 != name)
        loop(new_state)
      {:get, pid} ->
        send(pid, {:ok, state})
        loop(state)
    end
  end
end
