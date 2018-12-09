defmodule PlaygroundWeb.BoardControllerTest do
  use PlaygroundWeb.ConnCase

  alias Playground.Repo
  alias Playground.Todo
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

  describe "index" do
    test "lists all boards", %{conn: conn} do
      conn = get conn, board_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Boards"
    end
  end

  describe "new board" do
    test "renders form", %{conn: conn} do
      conn = get conn, board_path(conn, :new)
      assert html_response(conn, 200) =~ "New Board"
    end
  end

  describe "create board" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = create_user()
      conn = post conn, board_path(conn, :create), board: @create_attrs |> Map.merge(%{user_id: user.id})

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == board_path(conn, :show, id)

      conn = get conn, board_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Board"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, board_path(conn, :create), board: @invalid_attrs
      assert html_response(conn, 200) =~ "New Board"
    end
  end

  describe "edit board" do
    setup [:create_board]

    test "renders form for editing chosen board", %{conn: conn, board: board} do
      conn = get conn, board_path(conn, :edit, board)
      assert html_response(conn, 200) =~ "Edit Board"
    end
  end

  describe "update board" do
    setup [:create_board]

    test "redirects when data is valid", %{conn: conn, board: board} do
      conn = put conn, board_path(conn, :update, board), board: @update_attrs
      assert redirected_to(conn) == board_path(conn, :show, board)

      conn = get conn, board_path(conn, :show, board)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, board: board} do
      conn = put conn, board_path(conn, :update, board), board: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Board"
    end
  end

  describe "delete board" do
    setup [:create_board]

    test "deletes chosen board", %{conn: conn, board: board} do
      conn = delete conn, board_path(conn, :delete, board)
      assert redirected_to(conn) == board_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, board_path(conn, :show, board)
      end
    end
  end

  defp create_board(_) do
    board = fixture(:board)
    {:ok, board: board}
  end
end
