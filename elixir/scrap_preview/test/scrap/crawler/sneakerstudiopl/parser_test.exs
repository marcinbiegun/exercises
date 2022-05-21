defmodule Scrap.Crawler.Sneakerstudiopl.ParserTest do
  use ExUnit.Case
  doctest Scrap.Crawler.Sneakerstudiopl.Parser
  alias Scrap.Crawler.Sneakerstudiopl.Parser

  describe "product_urls/2" do
    test "it extracts links to product pages" do
      pages = Test.Data.html_page(:sneakerstudiopl, :index, 0)
      links = Parser.product_urls(pages, :index_page)

      assert length(links) == 96
      assert List.first(links) == "https://sneakerstudio.pl/product-pol-16702-Buty-meskie-sneakersy-New-Balance-Made-in-UK-Solway-Excursion-M7709FT.html"
      assert List.last(links) == "https://sneakerstudio.pl/product-pol-14352-Buty-meskie-sneakersy-New-Balance-ML574OUA.html"
    end
  end

  describe "products/1" do
    test "it extracts product data" do
      page = Test.Data.html_page(:sneakerstudiopl, :product, 0)
      {:ok, product} = Parser.product(page)
      assert product.brand == "New Balance"
      assert product.model == "MRL247"
      assert product.colorway == "MRL247TB"
      assert product.price == 319.0
      assert product.currency == "pln"
      assert product.sizes == [430, 440, 445, 450, 455, 465]
    end

    @tag debug: true
    test "it extracts product data from invalid (non-shoe page)" do
      page = Test.Data.html_page(:sneakerstudiopl, :product, 1)
      {:ok, product} = Parser.product(page)
      assert product.brand == "adidas Originals"
      assert product.model == "Trefoil Cap"
      assert product.colorway == "CD6973"
      assert product.price == 69.0
      assert product.currency == "pln"
      assert product.sizes == []
    end
  end

  # private function
  #describe "read_traits/1" do
    #test "it extracts raw traits" do
      #page = Test.Data.html_page(:sneakerstudiopl, :product, 0)
      #traits = Scrap.Parse.Sneakerstudiopl.read_traits(page)
      #assert traits[:"Numer katalogowy"] == "MRL247TB"
    #end
  #end

end
