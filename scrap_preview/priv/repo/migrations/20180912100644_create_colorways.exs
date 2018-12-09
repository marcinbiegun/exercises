defmodule Scrap.Repo.Migrations.CreateColorways do
  use Ecto.Migration

  def change do
    create table(:colorways) do
      add :name, :string
      add :identifier, :string
      add :model_id, references(:models, on_delete: :nothing)

      timestamps()
    end

    create index(:colorways, [:model_id])
  end
end
