defmodule Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [checkpw: 2, hashpwsalt: 1]

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

  def login(username, password) do
    user = Repo.get_by(Account, username: username)

    cond do
      user && checkpw(password, user.password_hash) ->
           {:ok, %{access_token: user.access_token}}
      true -> {:error, "no user"}
    end
  end

  def create(username, email, password) do
    changeset = registration_changeset(
                        %Account{},
                        %{ username: username, email: email,
                           access_token: UUID.uuid4(:hex),
                           password_hash: hashpwsalt(password)
                         }
                       )

    case Repo.insert(changeset) do
      {:ok,  user} ->
        {:ok, %{id: user.id, username: user.username, email: user.email,
          access_token: user.access_token, password_hash: user.password_hash}}

      {:error, changeset} -> {:error, changeset}
    end
  end

  def get(access_token) do
    user = Repo.get_by(Account, access_token: access_token)
    cond do
      user -> {:ok, %{id: user.id}}
      true -> {:error, "no user"}
    end
  end

end

