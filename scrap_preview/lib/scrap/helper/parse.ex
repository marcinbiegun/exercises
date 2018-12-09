defmodule Scrap.Helper.Parse do

  def split(text, separator) do
    [name, value] = text
    |> String.split(separator)
    |> Enum.map(fn str -> String.trim(str) end)
    [name, value]
  end

  def float(value, :pl) when is_float(value) do
    value
  end

  def float(value, :pl) when is_integer(value) do
    value / 1
  end

  def float(value, :pl) when is_binary(value) do
    {number, _} = value
    |> String.replace(".", "", global: true)
    |> String.replace(",", ".", global: true)
    |> String.trim
    |> Float.parse
    number
  end
end
