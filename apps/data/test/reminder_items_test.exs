defmodule Data.ReminderTest do
  alias Data.{Reminder, Repo}
  use ExUnit.Case, async: true

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "Reminders can be added" do
    uuid = UUID.uuid4(:hex)
    {:ok, saved_data} = Reminder.save(uuid, "First reminder")
    assert saved_data.reminder == "First reminder"
  end

  test "Reminders can be retrieved" do
    uuid = UUID.uuid4(:hex)
    {:ok, _} = Reminder.save(uuid, "First reminder")
    {:ok, _} = Reminder.save(uuid, "Second reminder")

    first_reminder  = Reminder.get(uuid) |> Enum.at(0)
    second_reminder = Reminder.get(uuid) |> Enum.at(1)

    assert {_, "First reminder"} = first_reminder
    assert {_, "Second reminder"} = second_reminder
  end

  test "Reminders can be deleted" do
    uuid = UUID.uuid4(:hex)
    {:ok, _} = Reminder.save(uuid, "First reminder")
    {:ok, _} = Reminder.save(uuid, "Second reminder")

    assert Enum.count(Reminder.get(uuid)) == 2

    {id,  _} = Enum.at(Reminder.get(uuid), 0)
    {:ok, _} = Reminder.delete(id)

    assert Enum.count(Reminder.get(uuid)) == 1
  end
end

