defmodule Reminders.MinderTest do
  use ExUnit.Case, async: true
  alias Reminders.Minder

  setup do
    Minder.start_link(MinderTest)
    {:ok, minder: MinderTest}
  end

  test "accepts a reminder", %{minder: minder} do
    {:ok, user} = Data.User.save("bob", "bob@example.com", UUID.uuid4(:hex))

    assert Minder.create(minder, user.access_token, "buy coffee") == :ok
    assert Minder.create(minder, user.access_token, "eat food") == :ok
  end

  test "returns all reminders for a uuid", %{minder: minder} do
    {:ok, user} = Data.User.save("bob", "bob@example.com", UUID.uuid4(:hex))

    assert Minder.get(minder, user.access_token) == []

    Minder.create(minder, user.access_token, "buy coffee")
    Minder.create(minder, user.access_token, "walk dog")

    reminders = Minder.get(minder, user.access_token)

    assert (Enum.at(reminders, 0)).reminder  == "buy coffee"
    assert (Enum.at(reminders, 1)).reminder  == "walk dog"
    assert Enum.count(reminders) == 2
  end
end

