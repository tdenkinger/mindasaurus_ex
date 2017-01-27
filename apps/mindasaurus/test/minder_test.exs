defmodule Mindasaurus.MinderTest do
  use ExUnit.Case, async: true
  alias Mindasaurus.Minder

  setup do
    {:ok, minder} = Minder.start_link
    {:ok, minder: minder}
  end

  test "accepts a reminder", %{minder: minder} do
    assert Minder.create(minder, :uuid12312, "buy coffee") == :ok
    assert Minder.create(minder, :uuid12312, "eat food") == :ok
  end

  test "returns an empty list of reminders for a non-existent uuid", %{minder: minder} do
    assert Minder.get(minder, :uuid12312) == []
  end

  test "returns all reminders for a uuid that has them", %{minder: minder} do
    Minder.create(minder, :uuid12312, "buy coffee")
    Minder.create(minder, :uuid12312, "walk dog")

    reminders = Minder.get(minder, :uuid12312)
    assert Enum.member?(reminders, "buy coffee")
    assert Enum.member?(reminders, "walk dog")
    refute Enum.member?(reminders, "don't exist")
  end
end

