defmodule Data.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Data.{Reminder, User, Repo}

  schema "users" do
    field :username, :string
    field :email, :string
    field :access_token, :string
    has_many :reminders, Reminder

    timestamps()
  end

  @allowed_fields ~w(username email access_token)

  def changeset(record, params \\ :empty) do
    record |> cast(params, @allowed_fields)
  end

  def save(username, email, access_token) do
    changeset = changeset(
                          %User{},
                          %{username: username, email: email,
                           access_token: access_token
                          }
                         )

    case Repo.insert(changeset) do
      {:ok,  user} ->
        {:ok, %{id: user.id, username: username, email: email, access_token: access_token}}

      {:error, _} -> {:error, changeset}
    end
  end

  def get(access_token) do
    (from "users", where: [access_token: ^access_token],
     select: [:id, :username, :email])
    |> Repo.one
  end
end

