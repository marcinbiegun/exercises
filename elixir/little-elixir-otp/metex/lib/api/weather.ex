defmodule Metex.API.Weather do
  def temperature_of(location) do
    Process.sleep(500)
    "#{location}: 3.5°C"
  end
end
