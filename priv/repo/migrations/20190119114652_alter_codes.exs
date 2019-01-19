defmodule Brave.Repo.Migrations.AlterCodes do
  use Ecto.Migration

  def change do
    alter table(:codes) do
      add :event_location, {:array, :float}, null: false
    end
  end
end
