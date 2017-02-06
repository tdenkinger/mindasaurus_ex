defmodule Data.Reminder do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Data.{Reminder, Repo}

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

  def save(user, reminder) do
    changeset = changeset(
                           %Reminder{},
                           %{user_id: user.id, reminder: reminder}
                         )

    case Repo.insert(changeset) do
      {:ok, saved_reminder}     -> {:ok, saved_reminder}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def get(user) do
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

