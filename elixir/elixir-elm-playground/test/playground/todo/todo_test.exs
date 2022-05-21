defmodule Playground.TodoTest do
  use Playground.DataCase

  alias Playground.Todo
  alias Playground.Coherence.User, as: User

  @user_attrs %{name: "test", email: "test@example.com", password: "test", password_confirmation: "test"}
  def user_fixture() do
    User.changeset(%User{}, @user_attrs)
    |> Repo.insert!
  end

  describe "boards" do
    alias Playground.Todo.Board

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil, user_id: nil}

    def board_fixture(attrs \\ %{}) do
      user = user_fixture()

      {:ok, board} =
        attrs
        |> Enum.into(@valid_attrs |> Map.merge(%{user_id: user.id}))
        |> Todo.create_board()

      board
    end

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert Todo.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert Todo.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      user = user_fixture()
      assert {:ok, %Board{} = board} = Todo.create_board(@valid_attrs |> Map.merge(%{user_id: user.id}))
      assert board.name == "some name"
      assert is_number(board.user_id)
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()
      assert {:ok, board} = Todo.update_board(board, @update_attrs)
      assert %Board{} = board
      assert board.name == "some updated name"
      assert is_number(board.user_id)
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_board(board, @invalid_attrs)
      assert board == Todo.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = Todo.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = Todo.change_board(board)
    end
  end

  describe "columns" do
    alias Playground.Todo.Column

    @valid_attrs %{name: "some name", weight: 42}
    @update_attrs %{name: "some updated name", weight: 43}
    @invalid_attrs %{name: nil, weight: nil, board_id: nil}

    def column_fixture(attrs \\ %{}) do
      board = board_fixture()
      {:ok, column} =
        attrs
        |> Enum.into(@valid_attrs |> Map.merge(%{board_id: board.id}))
        |> Todo.create_column()

      column
    end

    test "list_columns/0 returns all columns" do
      column = column_fixture()
      assert Todo.list_columns() == [column]
    end

    test "get_column!/1 returns the column with given id" do
      column = column_fixture()
      assert Todo.get_column!(column.id) == column
    end

    test "create_column/1 with valid data creates a column" do
      board = board_fixture()
      assert {:ok, %Column{} = column} = Todo.create_column(@valid_attrs |> Map.merge(%{board_id: board.id}))
      assert column.name == "some name"
      assert column.weight == 42
      assert is_number(column.board_id)
    end

    test "create_column/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_column(@invalid_attrs)
    end

    test "update_column/2 with valid data updates the column" do
      column = column_fixture()
      assert {:ok, column} = Todo.update_column(column, @update_attrs)
      assert %Column{} = column
      assert column.name == "some updated name"
      assert column.weight == 43
      assert is_number(column.board_id)
    end

    test "update_column/2 with invalid data returns error changeset" do
      column = column_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_column(column, @invalid_attrs)
      assert column == Todo.get_column!(column.id)
    end

    test "delete_column/1 deletes the column" do
      column = column_fixture()
      assert {:ok, %Column{}} = Todo.delete_column(column)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_column!(column.id) end
    end

    test "change_column/1 returns a column changeset" do
      column = column_fixture()
      assert %Ecto.Changeset{} = Todo.change_column(column)
    end
  end

  describe "tasks" do
    alias Playground.Todo.Task

    @valid_attrs %{description: "some description", is_done: false, name: "some name", weight: 42}
    @update_attrs %{description: "some updated description", is_done: true, name: "some updated name", weight: 43}
    @invalid_attrs %{description: nil, done_at: nil, name: nil, weight: nil}

    def task_fixture(attrs \\ %{}) do
      column = column_fixture()
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs |> Map.merge(%{column_id: column.id}))
        |> Todo.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todo.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todo.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      column = column_fixture()
      assert {:ok, %Task{} = task} = Todo.create_task(@valid_attrs |> Map.merge(%{column_id: column.id}))
      assert task.description == "some description"
      assert task.is_done == false
      assert task.name == "some name"
      assert task.weight == 42
      assert is_number(task.column_id)
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Todo.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.is_done == true
      assert task.name == "some updated name"
      assert task.weight == 43
      assert is_number(task.column_id)
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_task(task, @invalid_attrs)
      assert task == Todo.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todo.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todo.change_task(task)
    end
  end
end
