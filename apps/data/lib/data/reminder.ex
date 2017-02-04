defmodule Data.Reminder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reminders" do
    field :uuid, :string
    field :reminder, :string

    timestamps()
  end

  @required_fields ~w(uuid, reminder)
  @optional_fields ~w()

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, @required_fields, @optional_fields)
  end
end

