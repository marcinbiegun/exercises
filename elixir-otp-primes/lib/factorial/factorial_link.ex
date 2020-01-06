defmodule Factorial do
  defmodule Link do
    def start_link do
      spawn_link(__MODULE__, :loop, [[]])
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
end
