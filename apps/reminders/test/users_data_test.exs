defmodule Reminders.UserTest do
  use ExUnit.Case

  alias Reminders.{User, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, { :shared, self() })
  end

  test "Users can be created" do
    {:ok, user} = User.save("bob", "bob@example.com", UUID.uuid4(:hex))

    assert String.trim(user.access_token) != ""
    assert user.username                  == "bob"
    assert user.email                     == "bob@example.com"
  end

  test "User can be retrieved" do
    token = UUID.uuid4(:hex)
    {:ok, _} = User.save("bob", "bob@example.com", token)

    user = User.get(token)

    assert user.username == "bob"
    assert user.email    == "bob@example.com"
  end

  test "Changeset with valid attributes" do
    changeset = User.changeset(%User{}, %{email: "bob@example.com",
                                          username: "bab",
                                          access_token: UUID.uuid4(:hex)
                                         })
    assert changeset.valid?
  end

  test "Changeset with invalid attributes" do
    changeset = User.changeset(%User{}, %{email: "bob@example.com",
                                          username: "ab",
                                          access_token: UUID.uuid4(:hex)
                                         })
    refute changeset.valid?
  end
end

