defmodule Reminders.ReminderTest do
  use ExUnit.Case

  alias Reminders.{Reminder, User, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, { :shared, self() })
  end

  test "Reminders can be added" do
    {:ok, user} = User.save("bob", "bob@example.com", UUID.uuid4(:hex))

    {:ok, reminder} = Reminder.save(user.access_token, "First reminder")

    assert reminder.reminder == "First reminder"
    assert reminder.user_id == user.id
  end

  test "Reminders can be retrieved" do
    {:ok, user} = User.save("bob", "bob@example.com", UUID.uuid4(:hex))

    {:ok, _} = Reminder.save(user.access_token, "First reminder")
    {:ok, _} = Reminder.save(user.access_token, "Second reminder")

    first_reminder  = Reminder.get(user.access_token) |> Enum.at(0)
    second_reminder = Reminder.get(user.access_token) |> Enum.at(1)

    assert first_reminder.reminder  == "First reminder"
    assert second_reminder.reminder == "Second reminder"
  end

  test "Reminders can be deleted" do
    {:ok, user} = User.save("bob", "bob@example.com", UUID.uuid4(:hex))

    {:ok, first_reminder}  = Reminder.save(user.access_token, "First reminder")
    {:ok, _} = Reminder.save(user.access_token, "Second reminder")

    assert Enum.count(Reminder.get(user.access_token)) == 2

    Reminder.delete(user.access_token, first_reminder.id)

    assert Enum.count(Reminder.get(user.access_token)) == 1
  end
end

