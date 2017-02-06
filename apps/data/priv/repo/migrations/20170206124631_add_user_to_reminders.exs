defmodule Data.Repo.Migrations.AddUserToReminders do
  use Ecto.Migration

  def change do
    alter table(:reminders) do
      add    :user_id, references(:users)
      remove :uuid
    end
  end
end
