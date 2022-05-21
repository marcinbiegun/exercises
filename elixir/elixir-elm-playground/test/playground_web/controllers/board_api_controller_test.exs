defmodule PlaygroundWeb.BoardApiControllerTest do
  use PlaygroundWeb.ConnCase

  alias Playground.Repo
  alias Playground.Todo
  alias Playground.Todo.Board
  alias Playground.Coherence.User, as: User

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def create_user() do
    user_attrs = %{name: "test", email: "test@example.com", password: "test", password_confirmation: "test"}
    {:ok, user} = User.changeset(%User{}, user_attrs) |> Repo.insert
    user
  end

  def fixture(:board) do
    user = create_user()
    {:ok, board} = Todo.create_board(@create_attrs |> Map.merge(%{user_id: user.id}))
    board
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all boards", %{conn: conn} do
      conn = get conn, board_api_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create board" do
    test "renders board when data is valid", %{conn: conn} do
      user = create_user()
      conn = post conn, board_api_path(conn, :create), board: @create_attrs |> Map.merge(%{user_id: user.id})
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, board_api_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name",
        "user_id" => user.id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, board_api_path(conn, :create), board: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update board" do
    setup [:create_board]

    test "renders board when data is valid", %{conn: conn, board: %Board{id: id} = board} do
      conn = put conn, board_api_path(conn, :update, board), board: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, board_api_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name",
        "user_id" => board.user_id
      }
    end

    test "renders errors when data is invalid", %{conn: conn, board: board} do
      conn = put conn, board_api_path(conn, :update, board), board: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete board" do
    setup [:create_board]

    test "deletes chosen board", %{conn: conn, board: board} do
      conn = delete conn, board_api_path(conn, :delete, board)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, board_api_path(conn, :show, board)
      end
    end
  end

  defp create_board(_) do
    board = fixture(:board)
    {:ok, board: board}
  end
end
