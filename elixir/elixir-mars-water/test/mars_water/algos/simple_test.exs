defmodule MarsWater.Algos.SimpleTest do
  use ExUnit.Case
  alias MarsWater.Algos.Simple

  describe "test/1" do
    test "calculates the solution correctly case 1" do
      input = " 1 3 1 3 1 2 9 4 4 1 8"
      assert Simple.run(input) == " (1, 1, score: 33)"
    end

    test "calculates the solution correctly case 2" do
      input = "3 4 2 6 2 6 0 2 3 0 0 2 8 8 9 2 1 4"
      assert Simple.run(input) ==  " (2, 1, score: 37)\n (2, 2, score: 30)\n (3, 1, score: 27)"
    end
  end
end
