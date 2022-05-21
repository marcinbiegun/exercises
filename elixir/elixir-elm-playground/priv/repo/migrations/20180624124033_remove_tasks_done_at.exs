defmodule Playground.Repo.Migrations.RemoveTasksDoneAt do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      remove :done_at
    end
  end
end
