defmodule PlaygroundWeb.ColumnApiControllerTest do
  use PlaygroundWeb.ConnCase

  alias Playground.Repo, as: Repo
  alias Playground.Todo
  alias Playground.Todo.Column
  alias Playground.Todo.Board
  alias Playground.Coherence.User, as: User

  @create_attrs %{name: "some name", weight: 42}
  @update_attrs %{name: "some updated name", weight: 43}
  @invalid_attrs %{name: nil, weight: nil}

  def create_board() do
    user_attrs = %{name: "test", email: "test@example.com", password: "test", password_confirmation: "test"}
    {:ok, user} = User.changeset(%User{}, user_attrs) |> Repo.insert
    board_attrs = %{name: "some name", user_id: user.id}
    {:ok, board} = Board.changeset(%Board{}, board_attrs) |> Repo.insert
    board
  end

  def fixture(:column) do
    board = create_board()
    {:ok, column} = Todo.create_column(@create_attrs |> Map.merge(%{board_id: board.id}))
    column
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all columns", %{conn: conn} do
      conn = get conn, column_api_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  # describe "index with parameters" do
  #   setup [:create_column]
  #   test "lists all columns belongin to a board", %{conn: conn} do
  #     conn = get conn, column_api_path(conn, :index)
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  describe "create column" do
    test "renders column when data is valid", %{conn: conn} do
      board = create_board()
      conn = post conn, column_api_path(conn, :create), column: @create_attrs |> Map.merge(%{board_id: board.id})
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, column_api_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name",
        "weight" => 42,
        "board_id" => board.id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, column_api_path(conn, :create), column: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update column" do
    setup [:create_column]

    test "renders column when data is valid", %{conn: conn, column: %Column{id: id} = column} do
      conn = put conn, column_api_path(conn, :update, column), column: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, column_api_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name",
        "weight" => 43,
        "board_id" => column.board_id}
    end

    test "renders errors when data is invalid", %{conn: conn, column: column} do
      conn = put conn, column_api_path(conn, :update, column), column: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete column" do
    setup [:create_column]

    test "deletes chosen column", %{conn: conn, column: column} do
      conn = delete conn, column_api_path(conn, :delete, column)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, column_api_path(conn, :show, column)
      end
    end
  end

  defp create_column(_) do
    column = fixture(:column)
    {:ok, column: column}
  end
end
