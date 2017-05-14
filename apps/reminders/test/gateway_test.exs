defmodule Reminders.GatewayTest do
  use ExUnit.Case, async: true

  alias Reminders.{Gateway, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, { :shared, self() })

    Gateway.start_link(GatewayTest)

    Accounts.Gateway.start_link(AccountGateway)
    {:ok, user} = Accounts.Gateway.create(AccountGateway, "bob", "bob@example.com", "password")

    %{minder: GatewayTest, user: user}
  end

  test "accepts a reminder", %{minder: minder, user: user} do
    assert Gateway.create(minder, user.access_token, "buy coffee") == :ok
    assert Gateway.create(minder, user.access_token, "eat food") == :ok
  end

  test "returns all reminders for a uuid", %{minder: minder, user: user} do
    assert Gateway.get(minder, user.access_token) == []

    Gateway.create(minder, user.access_token, "buy coffee")
    Gateway.create(minder, user.access_token, "walk dog")

    reminders = Gateway.get(minder, user.access_token)

    assert (Enum.at(reminders, 0)).reminder  == "buy coffee"
    assert (Enum.at(reminders, 1)).reminder  == "walk dog"
    assert Enum.count(reminders) == 2
  end

  test "deletes a reminder for a user", %{minder: minder, user: user} do
    Gateway.create(minder, user.access_token, "buy coffee")
    Gateway.create(minder, user.access_token, "walk dog")

    reminders = Gateway.get(minder, user.access_token)

    reminder_to_delete = (List.first(reminders)).id
    {:ok, _reminder} = Gateway.delete(minder, user.access_token, reminder_to_delete)

    reminders = Gateway.get(minder, user.access_token)
    assert Enum.count(reminders) == 1
  end

  test "does not delete a reminder owned by another user", %{minder: minder, user: user} do
    fake_token = UUID.uuid4(:hex)

    Gateway.create(minder, user.access_token, "buy coffee")
    Gateway.create(minder, user.access_token, "walk dog")

    reminders = Gateway.get(minder, user.access_token)

    reminder_to_delete = (List.first(reminders)).id
    {:error, status} = Gateway.delete(minder, fake_token, reminder_to_delete)

    assert status == "unauthorized"

    reminders = Gateway.get(minder, user.access_token)

    assert Enum.count(reminders) == 2
  end
end

