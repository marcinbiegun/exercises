defmodule Playground.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string
      add :description, :text
      add :weight, :integer
      add :done_at, :naive_datetime
      add :list_id, references(:lists, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:list_id])
  end
end
