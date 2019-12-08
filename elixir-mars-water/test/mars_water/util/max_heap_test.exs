defmodule MarsWater.Util.MinMaxHeapTest do
  use ExUnit.Case
  alias MarsWater.Util.MaxHeap

  describe "MaxHeap" do
    test "Rerurns elements from the greatest to the samllest" do
      heap = MaxHeap.new()
      |> MaxHeap.insert({100, "data"})
      |> MaxHeap.insert({19, "data"})
      |> MaxHeap.insert({36, "data"})
      |> MaxHeap.insert({17, "data"})
      |> MaxHeap.insert({12, "data"})
      |> MaxHeap.insert({25, "data"})
      |> MaxHeap.insert({5, "data"})
      |> MaxHeap.insert({9, "data"})
      |> MaxHeap.insert({15, "data"})
      |> MaxHeap.insert({6, "data"})
      |> MaxHeap.insert({11, "data"})
      |> MaxHeap.insert({13, "data"})
      |> MaxHeap.insert({8, "data"})
      |> MaxHeap.insert({1, "data"})
      |> MaxHeap.insert({4, "data"})

      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 100
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 36
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 25
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 19
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 17
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 15
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 13
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 12
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 11
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 9
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 8
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 6
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 5
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 4
      { {score, _data}, heap } = MaxHeap.delete_smallest(heap)
      assert score == 1
    end
  end
end
