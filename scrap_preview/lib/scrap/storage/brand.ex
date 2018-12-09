defmodule Scrap.Storage.Brand do
  use Ecto.Schema
  import Ecto.Changeset


  schema "brands" do
    field :identifier, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(brand, attrs) do
    brand
    |> cast(attrs, [:name, :identifier])
    |> validate_required([:name, :identifier])
  end
end
