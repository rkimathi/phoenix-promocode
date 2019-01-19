defmodule Brave.Repo.Migrations.AlterCodes2 do
  use Ecto.Migration

  def change do
    alter table(:codes) do
      add :radius, :integer, null: false
    end
  end
end
