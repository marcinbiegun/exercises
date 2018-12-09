File.stream!("day1.input")
|> Stream.map(&String.trim/1)
|> Stream.map(&String.to_integer/1)
|> Enum.to_list
|> Stream.cycle
|> Enum.reduce_while({0, MapSet.new}, fn i, acc ->
  {last_freq, mapset} = acc
  freq = last_freq + i
  if MapSet.member?(mapset, freq) do
    {:halt, freq}
  else
    {:cont, {freq, MapSet.put(mapset, freq)}}
  end
end)
|> IO.puts
