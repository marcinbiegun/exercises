defmodule Playground.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :is_done, :boolean
    field :name, :string
    field :weight, :integer
    belongs_to :column, Playground.Todo.Column

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :weight, :is_done, :column_id])
    |> validate_required([:name, :weight, :is_done, :column_id])
  end
end
