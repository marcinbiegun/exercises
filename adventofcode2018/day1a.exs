File.stream!("day1.input")
|> Stream.map(&String.trim/1)
|> Stream.map(&String.to_integer/1)
|> Enum.to_list
|> Enum.sum
|> IO.puts
