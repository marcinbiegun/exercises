defmodule PlaygroundWeb.TaskApiControllerTest do
  use PlaygroundWeb.ConnCase

  alias Playground.Repo
  alias Playground.Todo
  alias Playground.Todo.Board
  alias Playground.Todo.Column
  alias Playground.Todo.Task
  alias Playground.Coherence.User, as: User

  @create_attrs %{description: "some description", is_done: false, name: "some name", weight: 42}
  @update_attrs %{description: "some updated description", is_done: true, name: "some updated name", weight: 43}
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

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get conn, task_api_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create task" do
    test "renders task when data is valid", %{conn: conn} do
      column = create_column()
      conn = post conn, task_api_path(conn, :create), task: @create_attrs |> Map.merge(%{column_id: column.id})
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, task_api_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "is_done" => false,
        "name" => "some name",
        "weight" => 42,
        "column_id" => column.id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, task_api_path(conn, :create), task: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update task" do
    setup [:create_task]

    test "renders task when data is valid", %{conn: conn, task: %Task{id: id} = task} do
      conn = put conn, task_api_path(conn, :update, task), task: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, task_api_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "is_done" => true,
        "name" => "some updated name",
        "weight" => 43,
        "column_id" => task.column_id}
    end

    test "renders errors when data is invalid", %{conn: conn, task: task} do
      conn = put conn, task_api_path(conn, :update, task), task: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "deletes chosen task", %{conn: conn, task: task} do
      conn = delete conn, task_api_path(conn, :delete, task)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, task_api_path(conn, :show, task)
      end
    end
  end

  defp create_task(_) do
    task = fixture(:task)
    {:ok, task: task}
  end
end
