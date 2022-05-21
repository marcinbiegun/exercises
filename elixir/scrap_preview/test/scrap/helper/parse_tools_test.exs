defmodule Scrap.Helper.ParseTest do
  use ExUnit.Case
  doctest Scrap.Helper.Parse
  alias Scrap.Helper.Parse

  describe "float wiht :pl notation" do
    test "it parses integer to float" do
      assert Parse.float(10, :pl) === 10.0
    end

    test "it parses float to float" do
      assert Parse.float(10.0, :pl) === 10.0
    end

    test "it price strings to float" do
      assert Parse.float("10,00 zł", :pl) === 10.0
      assert Parse.float(" 10 zł", :pl) === 10.0
      assert Parse.float("10  ", :pl) === 10.0

      assert Parse.float("1.000,00 pln", :pl) === 1000.0
      assert Parse.float("1000,00 pln", :pl) === 1000.0
      assert Parse.float("1000zł", :pl) === 1000.0
    end
  end
end

