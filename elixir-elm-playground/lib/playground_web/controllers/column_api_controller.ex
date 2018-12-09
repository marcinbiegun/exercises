defmodule PlaygroundWeb.ColumnApiController do
  use PlaygroundWeb, :controller

  alias Playground.Todo
  alias Playground.Todo.Column

  action_fallback PlaygroundWeb.FallbackController

  def index(conn, _params) do
    columns = Todo.list_columns()
    render(conn, "index.json", columns: columns)
  end

  def create(conn, %{"column" => column_params}) do
    with {:ok, %Column{} = column} <- Todo.create_column(column_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", column_api_path(conn, :show, column))
      |> render("show.json", column: column)
    end
  end

  def show(conn, %{"id" => id}) do
    column = Todo.get_column!(id)
    render(conn, "show.json", column: column)
  end

  def update(conn, %{"id" => id, "column" => column_params}) do
    column = Todo.get_column!(id)

    with {:ok, %Column{} = column} <- Todo.update_column(column, column_params) do
      render(conn, "show.json", column: column)
    end
  end

  def delete(conn, %{"id" => id}) do
    column = Todo.get_column!(id)
    with {:ok, %Column{}} <- Todo.delete_column(column) do
      send_resp(conn, :no_content, "")
    end
  end
end
