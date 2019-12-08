defmodule MarsWater.Algos.Heap do
  alias MarsWater.Util.MaxHeap

  @count_solutions_every 1000

  def run(input) when is_binary(input) do
    [results_requested, grid_size | measurements] =
      String.split(input, " ", trim: true)
      |> Enum.map(& Integer.parse(&1) |> elem(0))

    heap = build_heap(measurements, grid_size)
    reduce_results_until(measurements, heap, results_requested, grid_size)
    |> prepare_results(results_requested, grid_size)
  end

  def build_heap(measurements, grid_size) do
    {heap, _index} = Enum.reduce(measurements, {MaxHeap.new(), -1}, fn score, {heap, index} ->
      index = index + 1
      x = rem(index, grid_size)
      y = div(index, grid_size)
      heap = MaxHeap.insert(heap, {score, {x, y}})
      {heap, index}
    end)
    heap
  end

  def reduce_results_until(measurements, heap, results_requested, grid_size) do
    {_heap, map, _index} = Enum.reduce_while(measurements, {heap, %{}, -1}, fn _measurement, {heap, map, index} ->
      index = index + 1

      # Get largest score from heap
      {{score, {x, y}}, heap} = MaxHeap.delete_root(heap)

      # Add to all affected coords
      map = Enum.reduce(affected_coords(x, y), map, fn {aff_x, aff_y}, acc ->
        Map.update(acc, {aff_x, aff_y}, [score], & &1 ++ [score])
      end)

      # Check if we have enough results
      if rem(index, @count_solutions_every) == 0 or index == grid_size - 1 do
        map_complete = Enum.filter(Map.to_list(map), fn {{_x, _y}, scores} ->
          length(scores) == expected_scores(x, y, grid_size)
        end)

        if map_complete |> length >= results_requested do
          IO.puts "Calculated #{results_requested} results after processing #{index}/#{length(measurements)}"
          {:halt, {heap, map, index}}
        else
          {:cont, {heap, map, index}}
        end
      else
         {:cont, {heap, map, index}}
      end
    end)
    map
  end

  def prepare_results(map, results_requested, grid_size) do
    map
    |> Map.to_list
    |> Enum.filter(fn {{x, y}, _scores} ->
      if x < 0 or y < 0 or x > grid_size - 1 or y > grid_size - 1 do
        false
      else
        true
      end
    end)
    |> Enum.map(fn {coords, scores} ->
      {coords, Enum.sum(scores)}
    end)
    |> Enum.sort(fn {{_x1, y1}, _s1}, {{_x2, y2}, _s2} -> y1 < y2 end)
    |> Enum.sort(fn {{x1, _y1}, _s1}, {{x2, _y2}, _s2} -> x1 < x2 end)
    |> Enum.sort(fn {{_x1, _y1}, s1}, {{_x2, _y2}, s2} -> s1 > s2 end)
    |> Enum.take(results_requested)
    |> Enum.map(&format_result/1)
    |> Enum.join("\n")
  end

  def affected_coords(x, y) do
    [
      {x-1, y-1}, {x, y-1}, {x+1, y-1},
      {x-1, y},   {x, y},   {x+1, y},
      {x-1, y+1}, {x, y+1}, {x+1, y+1}
    ]
  end

  def expected_scores(x, y, grid_size) do
    min = 0
    max = grid_size - 1
    cond do
      x == min and y == min ->
        4
      x == min and y == max ->
        4
      x == max and y == min ->
        4
      x == max and y == max ->
        4
      x == min or x == max or y == min or y == max ->
        6
      true ->
        9
    end
  end

  def format_result({{x, y}, score}) do
    " (#{x}, #{y}, score: #{score})"
  end
end
