defmodule PlaygroundWeb.ColumnApiView do
  use PlaygroundWeb, :view
  alias PlaygroundWeb.ColumnApiView

  def render("index.json", %{columns: columns}) do
    %{data: render_many(columns, ColumnApiView, "column.json")}
  end

  def render("show.json", %{column: column}) do
    %{data: render_one(column, ColumnApiView, "column.json")}
  end

  def render("column.json", %{column_api: column_api}) do
    %{id: column_api.id,
      name: column_api.name,
      weight: column_api.weight,
      board_id: column_api.board_id}
  end
end
