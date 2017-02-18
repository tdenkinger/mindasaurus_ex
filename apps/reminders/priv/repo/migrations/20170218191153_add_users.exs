defmodule Reminders.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username,     :string
      add :email,        :string
      add :access_token, :string

      timestamps()
    end
  end
end
