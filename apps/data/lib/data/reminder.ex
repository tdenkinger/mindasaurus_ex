defmodule Data.Reminder do
  use Ecto.Schema
  import Ecto.Changeset

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
    changeset = changeset(%Data.Reminder{}, %{uuid: uuid, reminder: reminder})
    Data.Repo.insert!(changeset)
  end
end

