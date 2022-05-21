defmodule Scrap.Repo.Migrations.CreateModels do
  use Ecto.Migration

  def change do
    create table(:models) do
      add :name, :string
      add :identifier, :string
      add :brand_id, references(:brands, on_delete: :nothing)

      timestamps()
    end

    create index(:models, [:brand_id])
  end
end
