defmodule Playground.Repo.Migrations.AddTasksDone do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      add :is_done, :boolean, default: true, null: false
    end
  end
end
