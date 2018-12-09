defmodule Scrap.Storage.Colorway do
  use Ecto.Schema
  import Ecto.Changeset


  schema "colorways" do
    field :identifier, :string
    field :name, :string
    field :model_id, :id

    timestamps()
  end

  @doc false
  def changeset(colorway, attrs) do
    colorway
    |> cast(attrs, [:name, :identifier])
    |> validate_required([:name, :identifier])
  end
end
