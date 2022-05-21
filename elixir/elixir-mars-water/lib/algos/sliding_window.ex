defmodule MarsWater.Algos.SlidingWindow do
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
    grid = build_tuple_grid(measurements, grid_size)
    init_acc = {-1, 0, :right, nil, []}
    Enum.reduce(1..length(measurements), init_acc, fn _measurement, {last_x, last_y, last_direction, last_window, last_scores} ->
      {x, y, direction, move} = next_coord(last_x, last_y, last_direction, grid_size)
      window = next_window(last_window, move, grid, grid_size, x, y)
      score = {x, y, window_score(window)}
      {x, y, direction, window, [score] ++ last_scores}
    end)
    |> elem(4)
    |> Enum.sort(fn {_x1, _y1, s1}, {_x2, _y2, s2} -> s1 > s2 end)
  end

  # >--------\
  #          |
  # /--------/
  # |
  # \--------\
  #          |
  # <--------/
  def next_coord(x, y, direction, grid_size) do
    cond do
      x == grid_size and y == grid_size ->
        :done
      direction == :right and x < grid_size - 1 ->
        {x + 1, y, direction, :right}
      direction == :left and x > 0 ->
        {x - 1, y, direction, :left}
      true ->
        if direction == :right do
          {x, y + 1, :left, :down}
        else
          {0, y + 1, :right, :down}
        end
    end
  end

  def next_window(nil, _move, grid, grid_size, x, y) do
    {
      {grid_value(grid, grid_size, x-1, y-1), grid_value(grid, grid_size, x, y-1), grid_value(grid, grid_size, x+1, y-1)},
      {grid_value(grid, grid_size, x-1, y),   grid_value(grid, grid_size, x, y),   grid_value(grid, grid_size, x+1, y)},
      {grid_value(grid, grid_size, x-1, y+1), grid_value(grid, grid_size, x, y+1), grid_value(grid, grid_size, x+1, y+1)}
    }
  end

  def next_window(last_window, move, grid, grid_size, x, y) do
    case move do
      :left ->
        {
          {grid_value(grid, grid_size, x-1, y-1), window_value(last_window, 0, 0), window_value(last_window, 1, 0)},
          {grid_value(grid, grid_size, x-1, y),   window_value(last_window, 0, 1), window_value(last_window, 1, 1)},
          {grid_value(grid, grid_size, x-1, y+1), window_value(last_window, 0, 2), window_value(last_window, 1, 2)}
        }
      :right ->
        {
          {window_value(last_window, 1, 0), window_value(last_window, 2, 0), grid_value(grid, grid_size, x+1, y-1)},
          {window_value(last_window, 1, 1), window_value(last_window, 2, 1), grid_value(grid, grid_size, x+1, y)},
          {window_value(last_window, 1, 2), window_value(last_window, 2, 2), grid_value(grid, grid_size, x+1, y+1)}
        }
      :down ->
        {
          {window_value(last_window, 0, 1), window_value(last_window, 1, 1), window_value(last_window, 2, 1)},
          {window_value(last_window, 0, 2), window_value(last_window, 1, 2), window_value(last_window, 2, 2)},
          {grid_value(grid, grid_size, x-1, y+1), grid_value(grid, grid_size, x, y+1), grid_value(grid, grid_size, x+1, y+1)}
        }
    end
  end

  def window_value(window, x, y) do
    window |> elem(y) |> elem(x)
  end

  def grid_value(grid, grid_size, x, y) do
    if (x < 0 or x > grid_size - 1) or (y < 0 or y > grid_size - 1) do
      0
    else
      grid |> elem(y) |> elem(x)
    end
  end

  def window_score(window) do
    window_value(window, 0, 0) +
    window_value(window, 1, 0) +
    window_value(window, 2, 0) +
    window_value(window, 0, 1) +
    window_value(window, 1, 1) +
    window_value(window, 2, 1) +
    window_value(window, 0, 2) +
    window_value(window, 1, 2) +
    window_value(window, 2, 2)
  end

  def build_tuple_grid(measurements, grid_size) do
    Enum.chunk_every(measurements, grid_size)
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple
  end

  def format_result({x, y, score}) do
    " (#{x}, #{y}, score: #{score})"
  end
end
