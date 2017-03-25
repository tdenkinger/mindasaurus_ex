defmodule AccountsTest do
  use ExUnit.Case

  alias Accounts.{Repo, Account}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, { :shared, self() })
  end

  test "Account can be created" do
    {:ok, user} = Account.create("bob", "bob@example.com", "mysecret")

    refute user.access_token == nil
    assert user.username     == "bob"
    assert user.email        == "bob@example.com"
  end

  test "Access token can be retrieved via username/password" do
    {:ok, user} = Account.create("bob", "bob@example.com", "mysecret")
    {:ok, session} = Account.login("bob", "mysecret")

    assert session.access_token == user.access_token
  end
# test "Changeset with valid attributes" do
#     changeset = User.changeset(%User{}, %{email: "bob@example.com",
#                                           username: "bab",
#                                           access_token: UUID.uuid4(:hex)
#                                          })
#     assert changeset.valid?
#   end

#   test "Changeset with invalid attributes" do
#     changeset = User.changeset(%User{}, %{email: "bob@example.com",
#                                           username: "ab",
#                                           access_token: UUID.uuid4(:hex)
#                                          })
#     refute changeset.valid?
#   end

end

