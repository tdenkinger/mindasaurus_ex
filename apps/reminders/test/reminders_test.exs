defmodule Reminders.ReminderTest do
  use ExUnit.Case

  alias Reminders.{Reminder, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, { :shared, self() })

    Accounts.Gateway.start_link(AccountGateway)
    {:ok, account_gateway: AccountGateway}
  end

  test "Reminders can be added", %{account_gateway: account_gateway} do
    {:ok, user} = Accounts.Gateway.create(account_gateway, "bob", "bob@example.com", "password")
    {:ok, reminder} = Reminder.save(user.access_token, "First reminder")

    assert reminder.reminder == "First reminder"
    assert reminder.user_id == user.id
  end

  test "Reminders can be retrieved", %{account_gateway: account_gateway} do
    {:ok, user} = Accounts.Gateway.create(account_gateway, "bob", "bob@example.com", "password")

    {:ok, _} = Reminder.save(user.access_token, "First reminder")
    {:ok, _} = Reminder.save(user.access_token, "Second reminder")

    first_reminder  = Reminder.get(user.access_token) |> Enum.at(0)
    second_reminder = Reminder.get(user.access_token) |> Enum.at(1)

    assert first_reminder.reminder  == "First reminder"
    assert second_reminder.reminder == "Second reminder"
  end

  test "Reminders can be deleted", %{account_gateway: account_gateway} do
    {:ok, user} = Accounts.Gateway.create(account_gateway, "bob", "bob@example.com", "password")

    {:ok, first_reminder}  = Reminder.save(user.access_token, "First reminder")
    {:ok, _} = Reminder.save(user.access_token, "Second reminder")

    assert Enum.count(Reminder.get(user.access_token)) == 2

    Reminder.delete(user.access_token, first_reminder.id)

    assert Enum.count(Reminder.get(user.access_token)) == 1
  end
end

