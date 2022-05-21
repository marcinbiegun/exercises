defmodule PlaygroundWeb.BoardController do
  use PlaygroundWeb, :controller

  alias Playground.Todo
  alias Playground.Todo.Board

  def index(conn, _params) do
    boards = Todo.list_boards()
    render(conn, "index.html", boards: boards)
  end

  def new(conn, _params) do
    changeset = Todo.change_board(%Board{})
    users = Playground.Coherence.Schemas.list_user()
    |> Enum.map(fn user -> {user.name, user.id} end)
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"board" => board_params}) do
    case Todo.create_board(board_params) do
      {:ok, board} ->
        conn
        |> put_flash(:info, "Board created successfully.")
        |> redirect(to: board_path(conn, :show, board))
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Playground.Coherence.Schemas.list_user()
        |> Enum.map(fn user -> {user.name, user.id} end)
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    board = Todo.get_board!(id)
    render(conn, "show.html", board: board)
  end

  def edit(conn, %{"id" => id}) do
    board = Todo.get_board!(id)
    changeset = Todo.change_board(board)
    users = Playground.Coherence.Schemas.list_user()
    |> Enum.map(fn user -> {user.name, user.id} end)
    render(conn, "edit.html", board: board, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = Todo.get_board!(id)

    case Todo.update_board(board, board_params) do
      {:ok, board} ->
        conn
        |> put_flash(:info, "Board updated successfully.")
        |> redirect(to: board_path(conn, :show, board))
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Playground.Coherence.Schemas.list_user()
        |> Enum.map(fn user -> {user.name, user.id} end)
        render(conn, "edit.html", board: board, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    board = Todo.get_board!(id)
    {:ok, _board} = Todo.delete_board(board)

    conn
    |> put_flash(:info, "Board deleted successfully.")
    |> redirect(to: board_path(conn, :index))
  end
end
