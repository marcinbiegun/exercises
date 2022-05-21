defmodule PlaygroundWeb.BoardApiController do
  use PlaygroundWeb, :controller

  alias Playground.Todo
  alias Playground.Todo.Board

  action_fallback PlaygroundWeb.FallbackController

  def index(conn, _params) do
    boards = Todo.list_boards()
    render(conn, "index.json", boards: boards)
  end

  def create(conn, %{"board" => board_params}) do
    with {:ok, %Board{} = board} <- Todo.create_board(board_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", board_api_path(conn, :show, board))
      |> render("show.json", board: board)
    end
  end

  def show(conn, %{"id" => id}) do
    board = Todo.get_board!(id)
    render(conn, "show.json", board: board)
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = Todo.get_board!(id)

    with {:ok, %Board{} = board} <- Todo.update_board(board, board_params) do
      render(conn, "show.json", board: board)
    end
  end

  def delete(conn, %{"id" => id}) do
    board = Todo.get_board!(id)
    with {:ok, %Board{}} <- Todo.delete_board(board) do
      send_resp(conn, :no_content, "")
    end
  end
end
