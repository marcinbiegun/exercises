defmodule FlattenTest do
  use ExUnit.Case
  import Flatten
  doctest Flatten

  describe "flatten/1" do
    test "not implemented for nil" do
      assert_raise FunctionClauseError, fn ->
        flatten(nil)
      end
    end

    test "does nothing to flat list" do
      assert flatten([1, 2, 3]) == [1, 2, 3]
    end

    test "flattens nested list" do
      assert flatten([1, [2, 3]]) == [1, 2, 3]
    end

    test "flattens deeply nested list" do
      assert flatten([1, [[2, 3]], [[[[4]]]]]) == [1, 2, 3, 4]
    end

    test "flattens list containg multiple variable types" do
      given = [[1], ["hello"], [0.001], [:world], [%{weight: 500}]]
      expected = [1, "hello", 0.001, :world, %{weight: 500}]
      assert flatten(given) == expected
    end
  end
end
