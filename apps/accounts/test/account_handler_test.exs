defmodule Accounts.HandlerTest do
  use ExUnit.Case, async: true

  alias Accounts.{Handler, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, { :shared, self() })

    Handler.start_link(AccountHandlerTest)
    {:ok, handler: AccountHandlerTest}
  end

  test "Creates an account", %{handler: handler} do
    {:ok, user} = Handler.create(handler, "bob", "bob@example.com", "password")

    assert user.username     == "bob"
    assert user.email        == "bob@example.com"
    refute user.access_token == nil
  end

  test "Logs into an account with username/password", %{handler: handler} do
    {:ok, user} = Handler.create(handler, "bob", "bob@example.com", "password")
    {:ok, session} = Handler.login(handler, "bob", "password")

    assert session.access_token == user.access_token
  end

end

