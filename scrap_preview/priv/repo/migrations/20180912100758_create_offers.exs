defmodule Scrap.Repo.Migrations.CreateOffers do
  use Ecto.Migration

  def change do
    create table(:offers) do
      add :price, :float
      add :currency, :string
      add :sizes, {:array, :integer}
      add :url, :string
      add :store_id, references(:stores, on_delete: :nothing)
      add :brand_id, references(:brands, on_delete: :nothing)
      add :model_id, references(:models, on_delete: :nothing)
      add :colorway_id, references(:colorways, on_delete: :nothing)

      timestamps()
    end

    create index(:offers, [:store_id])
    create index(:offers, [:brand_id])
    create index(:offers, [:model_id])
    create index(:offers, [:colorway_id])
  end
end
