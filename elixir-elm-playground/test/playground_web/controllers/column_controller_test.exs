defmodule PlaygroundWeb.ColumnControllerTest do
  use PlaygroundWeb.ConnCase

  alias Playground.Repo, as: Repo
  alias Playground.Todo
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
    #{:ok, column} = Todo.create_column(@create_attrs)
    column
  end

  describe "index" do
    test "lists all columns", %{conn: conn} do
      conn = get conn, column_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Columns"
    end
  end

  describe "new column" do
    test "renders form", %{conn: conn} do
      conn = get conn, column_path(conn, :new)
      assert html_response(conn, 200) =~ "New Column"
    end
  end

  describe "create column" do
    test "redirects to show when data is valid", %{conn: conn} do
      board = create_board()
      conn = post conn, column_path(conn, :create), column: @create_attrs |> Map.merge(%{board_id: board.id})

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == column_path(conn, :show, id)

      conn = get conn, column_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Column"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, column_path(conn, :create), column: @invalid_attrs
      assert html_response(conn, 200) =~ "New Column"
    end
  end

  describe "edit column" do
    setup [:create_column]

    test "renders form for editing chosen column", %{conn: conn, column: column} do
      conn = get conn, column_path(conn, :edit, column)
      assert html_response(conn, 200) =~ "Edit Column"
    end
  end

  describe "update column" do
    setup [:create_column]

    test "redirects when data is valid", %{conn: conn, column: column} do
      conn = put conn, column_path(conn, :update, column), column: @update_attrs
      assert redirected_to(conn) == column_path(conn, :show, column)

      conn = get conn, column_path(conn, :show, column)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, column: column} do
      conn = put conn, column_path(conn, :update, column), column: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Column"
    end
  end

  describe "delete column" do
    setup [:create_column]

    test "deletes chosen column", %{conn: conn, column: column} do
      conn = delete conn, column_path(conn, :delete, column)
      assert redirected_to(conn) == column_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, column_path(conn, :show, column)
      end
    end
  end

  defp create_column(_) do
    column = fixture(:column)
    {:ok, column: column}
  end
end
