defmodule Scrap.Crawler.Sneakerstudiopl.Source do
  @type index_job :: {:index_page, atom, String.t}
  @type product_job :: {:product_page, atom, String.t}

  @store "sneakerstudiopl"
  alias Scrap.Crawler.Sneakerstudiopl.Parser

  @spec index_page_jobs() :: [index_job]
  def index_page_jobs do
    [
      {:index_page, :adidas, "https://sneakerstudio.pl/pol_m_MESKIE_Marki_adidas-649.html"},
      {:index_page, :new_balance, "https://sneakerstudio.pl/pol_m_MESKIE_Marki_NEW-BALANCE-638.html"},
      {:index_page, :nike, "https://sneakerstudio.pl/pol_m_MESKIE_Marki_NIKE-648.html"}
    ]
  end

  @spec find_jobs(:index_page, atom, String.t, String.t) :: [index_job | product_job]
  def find_jobs(:index_page, brand, url, body) do
    new_product_pages = Parser.product_urls(body, :index_page)
    |> Enum.map(fn product_url -> {:product_page, brand, product_url} end)
    new_index_pages = {:index_page, brand, next_category_url(url)}
    [new_index_pages] ++ new_product_pages
  end

  @spec read_product(any(), any(), any()) :: Struct.t
  def read_product(brand, url, body) do
    {:ok, product} = Parser.product(body)
    product |> attach_crawler_data(brand, url)
  end

  defp attach_crawler_data(data, brand, url) do
    data |> Map.merge(
      %{url: url,
       brand: "#{brand}",
       store: @store,
       sizes: data.sizes
    })
  end

  defp next_category_url(url) do
    counter_match = ~r/\?counter=(\d)+$/
    case Regex.run(counter_match, url) do
      [_, number] ->
        next_number = String.to_integer(number) + 1
        Regex.replace(counter_match, url, "?counter=#{next_number}")
      _ ->
        url <> "?counter=1"
    end
  end
end

