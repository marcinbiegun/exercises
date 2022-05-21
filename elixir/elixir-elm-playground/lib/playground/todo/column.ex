defmodule Playground.Todo.Column do
  use Ecto.Schema
  import Ecto.Changeset


  schema "columns" do
    field :name, :string
    field :weight, :integer
    belongs_to :board, Playground.Todo.Board

    timestamps()
  end

  @doc false
  def changeset(column, attrs) do
    column
    |> cast(attrs, [:name, :weight, :board_id])
    |> validate_required([:name, :weight, :board_id])
  end
end
