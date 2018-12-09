defmodule Scrap.Storage.OfferPoint do
  use Ecto.Schema
  import Ecto.Changeset


  schema "offer_points" do
    field :brand, :string
    field :colorway, :string
    field :currency, :string
    field :model, :string
    field :price, :float
    field :sizes, {:array, :integer}
    field :store, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(offer_point, attrs) do
    offer_point
    |> cast(attrs, [:brand, :store, :model, :colorway, :price, :currency, :sizes, :url])
    |> validate_required([:brand, :store, :price, :currency, :sizes, :url])
    |> validate_number(:price, greater_than: 0.0)
    |> validate_inclusion(:brand, Scrap.brands(:string))
    |> validate_inclusion(:store, Scrap.stores(:string))
    |> validate_inclusion(:currency, Scrap.currencies(:string))
  end
end
