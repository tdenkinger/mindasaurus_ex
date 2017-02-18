defmodule Reminders.Reminder do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Reminders.{Reminder, Repo}

  schema "reminders" do
    field :reminder, :string
    belongs_to :user, User

    timestamps()
  end

  @allowed_fields ~w(reminder user_id)

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, @allowed_fields)
  end

  def save(access_token, reminder) do
    user = Reminders.User.get(access_token)
    changeset = changeset(
                           %Reminder{},
                           %{user_id: user.id, reminder: reminder}
                         )

    case Repo.insert(changeset) do
      {:ok, saved_reminder} -> {:ok, saved_reminder}
      {:error, changeset}   -> {:error, changeset}
    end
  end

  def get(key) do
    user = Reminders.User.get(key)
    (from "reminders",
     where: [user_id: ^user.id ], select: [:id, :reminder])
    |> Repo.all
  end

  def delete(reminder_id) do
    reminder = Repo.get!(Reminder, reminder_id)
    case Repo.delete(reminder) do
      {:ok, deleted_reminder}-> {:ok, deleted_reminder}
      {:error, changeset}    -> {:error, changeset}
    end
  end
end

