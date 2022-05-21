defmodule MarsWaterTest do
  use ExUnit.Case
  doctest MarsWater

  test "greets the world" do
    assert MarsWater.hello() == :world
  end
end
