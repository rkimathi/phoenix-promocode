defmodule Brave.Repo.Migrations.CreateCodes do
  use Ecto.Migration

  def change do
    create table(:codes) do
      add :code, :string, null: false
      add :amount, :integer, null: false
      add :expiry_date, :date, null: false
      add :is_active, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(:codes, [:code])
  end
end
