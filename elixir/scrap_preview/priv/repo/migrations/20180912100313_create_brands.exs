defmodule Scrap.Repo.Migrations.CreateBrands do
  use Ecto.Migration

  def change do
    create table(:brands) do
      add :name, :string
      add :identifier, :string

      timestamps()
    end

  end
end
