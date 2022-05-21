defmodule PlaygroundWeb.ColumnController do
  use PlaygroundWeb, :controller

  alias Playground.Todo
  alias Playground.Todo.Column

  def index(conn, _params) do
    columns = Todo.list_columns()
    render(conn, "index.html", columns: columns)
  end

  def new(conn, _params) do
    changeset = Todo.change_column(%Column{})
    boards = Todo.list_boards()
    |> Enum.map(fn board -> {board.name, board.id} end)
    render(conn, "new.html", changeset: changeset, boards: boards)
  end

  def create(conn, %{"column" => column_params}) do
    case Todo.create_column(column_params) do
      {:ok, column} ->
        conn
        |> put_flash(:info, "Column created successfully.")
        |> redirect(to: column_path(conn, :show, column))
      {:error, %Ecto.Changeset{} = changeset} ->
        boards = Todo.list_boards()
        |> Enum.map(fn board -> {board.name, board.id} end)
        render(conn, "new.html", changeset: changeset, boards: boards)
    end
  end

  def show(conn, %{"id" => id}) do
    column = Todo.get_column!(id)
    render(conn, "show.html", column: column)
  end

  def edit(conn, %{"id" => id}) do
    column = Todo.get_column!(id)
    changeset = Todo.change_column(column)
    boards = Todo.list_boards()
    |> Enum.map(fn board -> {board.name, board.id} end)
    render(conn, "edit.html", column: column, changeset: changeset, boards: boards)
  end

  def update(conn, %{"id" => id, "column" => column_params}) do
    column = Todo.get_column!(id)

    case Todo.update_column(column, column_params) do
      {:ok, column} ->
        conn
        |> put_flash(:info, "Column updated successfully.")
        |> redirect(to: column_path(conn, :show, column))
      {:error, %Ecto.Changeset{} = changeset} ->
        boards = Todo.list_boards()
        |> Enum.map(fn board -> {board.name, board.id} end)
        render(conn, "edit.html", column: column, changeset: changeset, boards: boards)
    end
  end

  def delete(conn, %{"id" => id}) do
    column = Todo.get_column!(id)
    {:ok, _column} = Todo.delete_column(column)

    conn
    |> put_flash(:info, "Column deleted successfully.")
    |> redirect(to: column_path(conn, :index))
  end
end
