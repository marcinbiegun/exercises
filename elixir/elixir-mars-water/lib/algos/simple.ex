defmodule MarsWater.Algos.Simple do
  def run(input) when is_binary(input) do
    [results_requested, grid_size | measurements] =
      String.split(input, " ", trim: true)
      |> Enum.map(& Integer.parse(&1) |> elem(0))

    compute_water_scores(measurements, grid_size)
    |> Enum.take(results_requested)
    |> Enum.map(&format_result/1)
    |> Enum.join("\n")
  end

  def compute_water_scores(measurements, grid_size) do
    grid = build_grid(measurements, grid_size)
    for x <- 0..grid_size, y <- 0..grid_size do
      {x, y, water_score(grid, x, y)}
    end
    |> Enum.sort(fn {_x1, _y1, s1}, {_x2, _y2, s2} -> s1 > s2 end)
  end

  def build_grid(measurements, grid_size) do
    Enum.chunk_every(measurements, grid_size)
  end

  def water_score(grid, x, y) do
    for fetch_x <- (x-1)..(x+1), fetch_y <- (y-1)..(y+1) do
      fetch_score(grid, fetch_x, fetch_y)
    end
    |> Enum.sum()
  end

  def fetch_score(grid, x, y) do
    if x < 0 or y < 0 do
      0
    else
      Enum.at(grid, y, []) |> Enum.at(x, 0)
    end
  end

  def format_result({x, y, score}) do
    " (#{x}, #{y}, score: #{score})"
  end
end
