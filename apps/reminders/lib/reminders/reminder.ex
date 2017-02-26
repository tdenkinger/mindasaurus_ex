defmodule Reminders.Reminder do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Reminders.{Reminder, Repo, User}

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

  def get(access_token) do
    Repo.all(
             from r in Reminder,
             join: u in assoc(r, :user),
             where: u.access_token == ^access_token,
             select: %{id: r.id, reminder: r.reminder}
           )
  end

  def delete(access_token, reminder_id) do
    reminder =
      Reminder
      |> where([r], r.id == ^reminder_id)
      |> preload(:user)
      |> Repo.one

    case reminder.user.access_token == access_token do
      true ->
        case Repo.delete(reminder) do
          {:ok, deleted_reminder}-> {:ok, deleted_reminder}
          {:error, changeset}    -> {:error, changeset}
        end
      _ -> {:error, "unauthorized"}
    end
  end
end

