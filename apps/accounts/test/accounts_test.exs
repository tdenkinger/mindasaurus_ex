defmodule AccountsTest do
  use ExUnit.Case

  alias Accounts.{Account, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, { :shared, self() })
  end

  test "Changeset with valid attributes" do
    changeset = Account.registration_changeset(%Account{},
                                               %{ email: "bob@example.com",
                                                  username: "bab",
                                                  access_token: UUID.uuid4(:hex)
                                                }
                                              )
    assert changeset.valid?
  end

  test "Changeset with invalid attributes" do
    changeset = Account.registration_changeset(%Account{},
                                               %{ email: "bob@example.com",
                                                  username: "ab",
                                                  access_token: UUID.uuid4(:hex)
                                                }
                                              )
    refute changeset.valid?
  end

end

