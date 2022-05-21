defmodule Scrap.Crawler.Sneakerstudiopl.SourceTest do
  use ExUnit.Case
  doctest Scrap.Crawler.Sneakerstudiopl.Source
  alias Scrap.Crawler.Sneakerstudiopl.Source

  describe "find_jobs/4" do
    test "it returns crawler jobs from index_page contents" do
      brand = :nike
      url = "https://sneakerstudio.pl/something.html?counter=1"
      body = Test.Data.html_page(:sneakerstudiopl, :index, 0)
      [index_job | product_jobs] = Source.find_jobs(:index_page, brand, url, body)

      assert index_job == {:index_page, :nike, "https://sneakerstudio.pl/something.html?counter=2"}
      assert length(product_jobs) == 96
      assert hd(product_jobs) == {:product_page, brand, "https://sneakerstudio.pl/product-pol-16702-Buty-meskie-sneakersy-New-Balance-Made-in-UK-Solway-Excursion-M7709FT.html"}
    end
  end

  describe "read_product/3" do
    test "returns parsed product data" do
      brand = :new_balance
      url = "some product url"
      body = Test.Data.html_page(:sneakerstudiopl, :product, 0)
      product = Source.read_product(brand, url, body)

      assert product.colorway == "MRL247TB"
      assert product.url == url
      assert product.brand == "#{brand}"
    end
  end

end

