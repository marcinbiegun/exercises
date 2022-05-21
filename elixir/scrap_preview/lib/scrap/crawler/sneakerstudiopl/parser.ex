defmodule Scrap.Crawler.Sneakerstudiopl.Parser do
  alias Scrap.Helper.Parse
  @base_url "https://sneakerstudio.pl"

  @spec product_urls(String.t, :index_page) :: [Struct.t]
  def product_urls(index_page, :index_page) do
    parse_index_page(index_page)
  end

  @spec product(String.t) :: Struct.t
  def product(product_page) do
    parse_product_page(product_page)
  end

  defp parse_index_page(html) do
    html
    |> Floki.find("div.product_wrapper a.product-icon")
    |> Floki.attribute("href")
    |> Enum.map(fn url -> @base_url <> url end)
  end

  defp parse_product_page(html) do
    traits = read_traits(html)
    product = %{
      brand: traits[:"Producent"],
      model: traits[:"Model"],
      colorway: traits[:"Numer katalogowy"],
      price: read_price(html),
      currency: "pln",
      sizes: read_sizes(html)
    }
    {:ok, product}
  end

  defp read_price(html) do
    html
    |> Floki.find("#projector_price_value")
    |> Floki.text
    |> Parse.float(:pl)
  end

  defp read_sizes(html) do
    html
    |> Floki.find(".size_cyfra_parent")
    |> Enum.map(fn el ->
      el
      |> Floki.find("label.select_button")
      |> Floki.attribute("data-eu")
    end)
    |> List.flatten
    |> Enum.map(&Parse.float(&1, :pl))
    |> Enum.map(&trunc(&1 * 10))
  end

  defp read_traits(html) do
    html
    |> Floki.find("div.desc_trait")
    |> Enum.map(&Floki.text/1)
    |> Enum.filter(fn s -> s =~ ":" end)
    |> Enum.map(fn s -> String.split(s, ":") |> Enum.map(&String.trim/1) end)
    |> Stream.map(fn [k, v] -> { String.to_atom(k), v} end)
    |> Enum.into(%{})
  end
end

