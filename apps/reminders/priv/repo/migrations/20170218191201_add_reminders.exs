defmodule Reminders.Repo.Migrations.AddReminder do
  use Ecto.Migration

  def change do
    create table(:reminders) do
      add :user_id, references(:users)
      add :reminder, :string

      timestamps()
    end
  end
end
