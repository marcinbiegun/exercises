defmodule Playground.Todo.Board do
  use Ecto.Schema
  import Ecto.Changeset


  schema "boards" do
    field :name, :string
    belongs_to :user, Playground.Todo.User

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
