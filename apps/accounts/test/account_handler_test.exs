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
    {:ok, account} = Handler.create(handler, "bob", "bob@example.com", "mysecret")

    assert account.username     == "bob"
    assert account.email        == "bob@example.com"
    refute account.access_token == nil
  end
end

