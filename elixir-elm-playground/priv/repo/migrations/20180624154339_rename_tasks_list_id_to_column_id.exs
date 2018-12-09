defmodule Playground.Repo.Migrations.RenameTasksListIdToColumnId do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      remove :list_id
      add :column_id, references(:columns, on_delete: :nothing)
    end
  end
end
