defmodule Accounts.GatewayTest do
  use ExUnit.Case, async: true

  alias Accounts.{Gateway, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, { :shared, self() })

    Gateway.start_link(GatewayTest)
    {:ok, handler: GatewayTest}
  end

  test "Creates an account", %{handler: handler} do
    {:ok, user} = Gateway.create(handler, "bob", "bob@example.com", "password")

    assert user.username     == "bob"
    assert user.email        == "bob@example.com"
    refute user.access_token == nil
  end

  test "Logs into an account with username/password", %{handler: handler} do
    {:ok, user} = Gateway.create(handler, "bob", "bob@example.com", "password")
    {:ok, session} = Gateway.login(handler, "bob", "password")

    assert session.access_token == user.access_token
  end

end

