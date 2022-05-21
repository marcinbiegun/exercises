defmodule MarsWater.Algos.StreamingTest do
  use ExUnit.Case
  alias MarsWater.Algos.Streaming

  describe "test/1" do
    @tag :dev
    test "calculates the solution correctly case 1" do
      path = "./test/files/mars_example0.txt"
      assert Streaming.run(path) == " (1, 1, score: 33)"
    end

    test "calculates the solution correctly case 2" do
      path = "./test/files/mars_example1.txt"
      assert Streaming.run(path) ==  " (2, 1, score: 37)\n (2, 2, score: 30)\n (3, 1, score: 27)"
    end
  end
end
