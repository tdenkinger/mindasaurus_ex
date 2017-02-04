defmodule Data.Repo.Migrations.AddReminders do
  use Ecto.Migration

  def change do
    create table(:reminders) do
      add :uuid, :string
      add :reminder, :string

      timestamps()
    end
  end
end
