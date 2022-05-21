defmodule MarsWater.Algos.Streaming do
  def run(path) when is_binary(path) do
    assume_first_two_chars_in_bytes = 100

    [first, second | _rest] = File.stream!(path, [] , assume_first_two_chars_in_bytes)
    |> Enum.take(1)
    |> Enum.join(" ")
    |> String.trim()
    |> String.split(" ")

    {results_requested, ""} = Integer.parse(first)
    {grid_size, ""} = Integer.parse(second)

    skip_chars = 2
    File.stream!(path, [] , 1)
    |> Enum.reduce({%{}, -1}, fn char, {scores, index} ->
      case Integer.parse(char) do
        {amount, ""} ->
          index = index + 1
          if index < skip_chars do
            {scores, index}
          else
            coords = affected_coords(index - skip_chars, grid_size)
            scores = update_scores(scores, coords, amount)
            {scores, index}
          end
        _ ->
          {scores, index}
      end
    end)
    |> elem(0)
    |> Map.to_list()
    |> Enum.sort(fn {_coords1, score1}, {_coords2, score2} -> score1 > score2 end)
    |> Enum.take(results_requested)
    |> Enum.map(&format_result/1)
    |> Enum.join("\n")
  end

  def affected_coords(index, grid_size) do
    x = rem(index, grid_size)
    y = div(index, grid_size)

    [
      {x-1, y-1}, {x, y-1}, {x+1, y-1},
      {x-1, y},   {x, y},   {x+1, y},
      {x-1, y+1}, {x, y+1}, {x+1, y+1}
    ]
    |> Enum.reject(fn {x, y} ->
      (x < 0 or x > grid_size - 1) or (y < 0 or y > grid_size - 1)
    end)
  end

  def update_scores(scores, coords, amount) do
    Enum.reduce(coords, scores, fn {x, y}, acc ->
      Map.update(acc, {x, y}, amount, & &1 + amount)
    end)
  end

  def format_result({{x, y}, score}) do
    " (#{x}, #{y}, score: #{score})"
  end
end
