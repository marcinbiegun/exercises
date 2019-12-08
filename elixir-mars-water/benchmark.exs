list = Enum.to_list(1..10_000)
map_fun = fn i -> [i, i * i] end

path = "./test/files/mars_10k.txt"
#path = "./test/files/mars_1m.txt"

alias MarsWater.Algos.Simple
alias MarsWater.Algos.SlidingWindow
alias MarsWater.Algos.Streaming
alias MarsWater.Algos.Heap

# File.read!(path) |> Simple.run() |> IO.inspect
# File.read!(path) |> SlidingWindow.run() |> IO.inspect
# Streming.run(path) |> IO.inspect

Benchee.run(%{
  "simple" => fn -> File.read!(path) |> Simple.run() end,
  "sliding_window" => fn -> File.read!(path) |> SlidingWindow.run() end,
  "streaming" => fn -> Streaming.run(path) end,
  "heap" => fn -> File.read!(path) |> Heap.run() end
})
