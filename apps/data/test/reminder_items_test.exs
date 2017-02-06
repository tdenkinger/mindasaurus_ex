defmodule Data.ReminderTest do
  use ExUnit.Case, async: true

  alias Data.{Reminder, User, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "Reminders can be added" do
    {:ok, user} = User.save("bob", "bob@example.com", UUID.uuid4(:hex))

    {:ok, reminder} = Reminder.save(user, "First reminder")

    assert reminder.reminder == "First reminder"
    assert reminder.user_id == user.id
  end

  test "Reminders can be retrieved" do
    {:ok, user} = User.save("bob", "bob@example.com", UUID.uuid4(:hex))

    {:ok, _} = Reminder.save(user, "First reminder")
    {:ok, _} = Reminder.save(user, "Second reminder")

    first_reminder  = Reminder.get(user) |> Enum.at(0)
    second_reminder = Reminder.get(user) |> Enum.at(1)

    assert first_reminder.reminder  == "First reminder"
    assert second_reminder.reminder == "Second reminder"
  end

  test "Reminders can be deleted" do
    {:ok, user} = User.save("bob", "bob@example.com", UUID.uuid4(:hex))

    {:ok, first_reminder}  = Reminder.save(user, "First reminder")
    {:ok, _} = Reminder.save(user, "Second reminder")

    assert Enum.count(Reminder.get(user)) == 2

    Reminder.delete(first_reminder.id)

    assert Enum.count(Reminder.get(user)) == 1
  end
end

