defmodule Scrap.Storage.Offer do
  use Ecto.Schema
  import Ecto.Changeset


  schema "offers" do
    field :currency, :string
    field :price, :float
    field :sizes, {:array, :integer}
    field :url, :string
    field :store_id, :id
    field :brand_id, :id
    field :model_id, :id
    field :colorway_id, :id

    timestamps()
  end

  @doc false
  def changeset(offer, attrs) do
    offer
    |> cast(attrs, [:price, :currency, :sizes, :url])
    |> validate_required([:price, :currency, :sizes, :url])
  end
end
