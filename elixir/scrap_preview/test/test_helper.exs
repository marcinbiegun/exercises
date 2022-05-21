ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Scrap.Repo, :manual)

defmodule Test.Data do
  def html_page(source, type, index) do
    File.read!("test/data/#{source}/#{type}#{index}.html")
  end

  def html_pages(source, type, indexes) do
    Enum.map(indexes, fn i -> html_page(source, type, i) end)
  end
end
