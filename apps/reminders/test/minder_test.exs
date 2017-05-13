defmodule Reminders.MinderTest do
  use ExUnit.Case, async: true

  alias Reminders.{Minder, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, { :shared, self() })

    Minder.start_link(MinderTest)

    {:ok, user} = Accounts.Handler.create(AccountHandler, "bob", "bob@example.com", "password")

    %{minder: MinderTest, user: user}
  end

  test "accepts a reminder", %{minder: minder, user: user} do
    assert Minder.create(minder, user.access_token, "buy coffee") == :ok
    assert Minder.create(minder, user.access_token, "eat food") == :ok
  end

  test "returns all reminders for a uuid", %{minder: minder, user: user} do
    assert Minder.get(minder, user.access_token) == []

    Minder.create(minder, user.access_token, "buy coffee")
    Minder.create(minder, user.access_token, "walk dog")

    reminders = Minder.get(minder, user.access_token)

    assert (Enum.at(reminders, 0)).reminder  == "buy coffee"
    assert (Enum.at(reminders, 1)).reminder  == "walk dog"
    assert Enum.count(reminders) == 2
  end

  test "deletes a reminder for a user", %{minder: minder, user: user} do
    Minder.create(minder, user.access_token, "buy coffee")
    Minder.create(minder, user.access_token, "walk dog")

    reminders = Minder.get(minder, user.access_token)

    reminder_to_delete = (List.first(reminders)).id
    {:ok, _reminder} = Minder.delete(minder, user.access_token, reminder_to_delete)

    reminders = Minder.get(minder, user.access_token)
    assert Enum.count(reminders) == 1
  end

  test "does not delete a reminder owned by another user", %{minder: minder, user: user} do
    fake_token = UUID.uuid4(:hex)

    Minder.create(minder, user.access_token, "buy coffee")
    Minder.create(minder, user.access_token, "walk dog")

    reminders = Minder.get(minder, user.access_token)

    reminder_to_delete = (List.first(reminders)).id
    {:error, status} = Minder.delete(minder, fake_token, reminder_to_delete)

    assert status == "unauthorized"

    reminders = Minder.get(minder, user.access_token)

    assert Enum.count(reminders) == 2
  end

end

