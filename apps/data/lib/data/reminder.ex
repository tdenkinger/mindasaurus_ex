defmodule Data.Reminder do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Data.{Reminder, Repo}

  schema "reminders" do
    field :uuid, :string
    field :reminder, :string

    timestamps()
  end

  @allowed_fields ~w(uuid reminder)

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, @allowed_fields)
  end

  def save(uuid, reminder) do
    changeset = changeset(
                           %Reminder{},
                           %{uuid: uuid, reminder: reminder}
                         )

    case Repo.insert(changeset) do
      {:ok, reminder}     -> {:ok, reminder}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def get(uuid) do
    (from r in Reminder,
     where: r.uuid == ^uuid,
     select: {r.id, r.reminder})
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

