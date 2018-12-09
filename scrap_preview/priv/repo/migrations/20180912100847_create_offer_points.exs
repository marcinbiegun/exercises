defmodule Scrap.Repo.Migrations.CreateOfferPoints do
  use Ecto.Migration

  def change do
    create table(:offer_points) do
      add :model, :string
      add :colorway, :string
      add :brand, :string
      add :store, :string
      add :price, :float
      add :currency, :string
      add :sizes, {:array, :integer}
      add :url, :string

      timestamps()
    end

  end
end
