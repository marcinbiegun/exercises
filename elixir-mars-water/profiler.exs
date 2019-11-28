defmodule Profiler do
  import ExProf.Macro

  @doc "analyze with profile macro"
  def do_analyze do
    profile do
      path = "./test/files/mars_10k.txt"

      #File.read!(path) |> MarsWater.Algos.Simple.run()
      #File.read!(path) |> MarsWater.Algos.SlidingWindow.run()
      MarsWater.Algos.Streaming.run(path)
    end
  end

  @doc "get analysis records and sum them up"
  def run do
    {records, _block_result} = do_analyze
    total_percent = Enum.reduce(records, 0.0, &(&1.percent + &2))
    IO.inspect "total = #{total_percent}"
  end
end

Profiler.run
