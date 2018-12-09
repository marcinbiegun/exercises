defmodule Scrap.Storage.Store do
  use Ecto.Schema
  import Ecto.Changeset


  schema "stores" do
    field :identifier, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:name, :identifier])
    |> validate_required([:name, :identifier])
  end
end
