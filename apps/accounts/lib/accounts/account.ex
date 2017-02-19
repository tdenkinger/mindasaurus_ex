defmodule Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Accounts.{Account, Repo}

  schema "users" do
    field :username,      :string
    field :email,         :string
    field :access_token,  :string
    field :password_hash, :string
    field :password,      :string, virtual: true

    timestamps()
  end

  @allowed_fields ~w(username email access_token password_hash)

  def registration_changeset(record, params \\ :empty) do
    record
    |> cast(params, @allowed_fields)
    |> validate_length(:username, min: 3, max: 255)
  end

  def create(username, email, password) do
    changeset = registration_changeset(
                        %Account{},
                        %{ username: username, email: email,
                           access_token: UUID.uuid4(:hex),
                           password_hash: Comeonin.Bcrypt.hashpwsalt(password)
                         }
                       )

    case Repo.insert(changeset) do
      {:ok,  user} ->
        {:ok, %{id: user.id, username: user.username, email: user.email,
          access_token: user.access_token, password_hash: user.password_hash}}

      {:error, changeset} -> {:error, changeset}
    end
  end
end

