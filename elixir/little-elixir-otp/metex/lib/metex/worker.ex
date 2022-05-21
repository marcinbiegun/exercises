defmodule Metex.Worker do
  def loop do
    receive do
      {sender_pid, location} ->
        send(sender_pid, {:ok, Metex.API.Weather.temperature_of(location)})

      _ ->
        IO.puts("Unknown message")
    end

    loop()
  end
end
