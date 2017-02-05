defmodule Domain.MinderTest do
  use ExUnit.Case, async: true
  alias Domain.Minder

  setup do
    Minder.start_link(MinderTest)
    {:ok, minder: MinderTest}
  end

  test "accepts a reminder", %{minder: minder} do
    uuid = UUID.uuid4(:hex)
    assert Minder.create(minder, uuid, "buy coffee") == :ok
    assert Minder.create(minder, uuid, "eat food") == :ok
  end

  test "errors when a uuid is invalid", %{minder: minder} do
    status = Minder.create(minder, :bad_id, "buy coffee")
    assert elem(status, 0) == :error
  end

  test "returns an empty list of reminders for a non-existent uuid", %{minder: minder} do
    uuid = "does_not_exist"
    assert Minder.get(minder, uuid) == []
  end

  test "returns all reminders for a uuid", %{minder: minder} do
    uuid = UUID.uuid4(:hex)
    assert Minder.get(minder, uuid) == []

    Minder.create(minder, uuid, "buy coffee")
    Minder.create(minder, uuid, "walk dog")

    reminders = Minder.get(minder, uuid)

    assert (Enum.at(reminders, 0) |> elem(1)) == "buy coffee"
    assert (Enum.at(reminders, 1) |> elem(1)) == "walk dog"
    assert Enum.count(reminders) == 2
  end
end

