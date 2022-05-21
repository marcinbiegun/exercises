defmodule PlaygroundWeb.TaskControllerTest do
  use PlaygroundWeb.ConnCase

  alias Playground.Repo
  alias Playground.Todo
  alias Playground.Todo.Board
  alias Playground.Todo.Column
  alias Playground.Coherence.User, as: User

  @create_attrs %{description: "some description", is_done: false, name: "some name", weight: 42}
  @update_attrs %{description: "some updated description", is_done: false, name: "some updated name", weight: 43}
  @invalid_attrs %{description: nil, is_done: nil, name: nil, weight: nil}

  def create_column() do
    user_attrs = %{name: "test", email: "test@example.com", password: "test", password_confirmation: "test"}
    {:ok, user} = User.changeset(%User{}, user_attrs) |> Repo.insert
    board_attrs = %{name: "some name", user_id: user.id}
    {:ok, board} = Board.changeset(%Board{}, board_attrs) |> Repo.insert
    column_attrs = %{name: "some name", weight: 1, board_id: board.id}
    {:ok, column} = Column.changeset(%Column{}, column_attrs) |> Repo.insert
    column
  end

  def fixture(:task) do
    column = create_column()
    {:ok, task} = Todo.create_task(@create_attrs |> Map.merge(%{column_id: column.id}))
    task
  end

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get conn, task_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Tasks"
    end
  end

  describe "new task" do
    test "renders form", %{conn: conn} do
      conn = get conn, task_path(conn, :new)
      assert html_response(conn, 200) =~ "New Task"
    end
  end

  describe "create task" do
    test "redirects to show when data is valid", %{conn: conn} do
      column = create_column()
      conn = post conn, task_path(conn, :create), task: @create_attrs |> Map.merge(%{column_id: column.id})

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == task_path(conn, :show, id)

      conn = get conn, task_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Task"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, task_path(conn, :create), task: @invalid_attrs
      assert html_response(conn, 200) =~ "New Task"
    end
  end

  describe "edit task" do
    setup [:create_task]

    test "renders form for editing chosen task", %{conn: conn, task: task} do
      conn = get conn, task_path(conn, :edit, task)
      assert html_response(conn, 200) =~ "Edit Task"
    end
  end

  describe "update task" do
    setup [:create_task]

    test "redirects when data is valid", %{conn: conn, task: task} do
      conn = put conn, task_path(conn, :update, task), task: @update_attrs
      assert redirected_to(conn) == task_path(conn, :show, task)

      conn = get conn, task_path(conn, :show, task)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, task: task} do
      conn = put conn, task_path(conn, :update, task), task: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Task"
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "deletes chosen task", %{conn: conn, task: task} do
      conn = delete conn, task_path(conn, :delete, task)
      assert redirected_to(conn) == task_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, task_path(conn, :show, task)
      end
    end
  end

  defp create_task(_) do
    task = fixture(:task)
    {:ok, task: task}
  end
end
