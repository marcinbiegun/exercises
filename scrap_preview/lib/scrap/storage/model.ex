defmodule Scrap.Storage.Model do
  use Ecto.Schema
  import Ecto.Changeset


  schema "models" do
    field :identifier, :string
    field :name, :string
    field :brand_id, :id

    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:name, :identifier])
    |> validate_required([:name, :identifier])
  end
end
