defmodule Playground.Repo.Migrations.RenameListsToColumns do
  use Ecto.Migration

  def change do
    rename table("lists"), to: table("columns")
  end
end
