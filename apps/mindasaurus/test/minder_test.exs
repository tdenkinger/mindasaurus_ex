defmodule Mindasaurus.MinderTest do
  use ExUnit.Case, async: true
  doctest Mindasaurus.Minder

  test "accepts a reminder" do
    {:ok, minder} = Mindasaurus.Minder.start_link
    assert Mindasaurus.Minder.create(minder, :uuid12312, "buy coffee") == :ok
    assert Mindasaurus.Minder.create(minder, :uuid12312, "eat food") == :ok
  end

  test "returns an empty list of reminders for a non-existent uuid" do
    {:ok, minder} = Mindasaurus.Minder.start_link

    assert Mindasaurus.Minder.get(minder, :uuid12312) == []
  end

  test "returns all reminders for a uuid that has them" do
    {:ok, minder} = Mindasaurus.Minder.start_link
    Mindasaurus.Minder.create(minder, :uuid12312, "buy coffee")
    Mindasaurus.Minder.create(minder, :uuid12312, "walk dog")

    reminders = Mindasaurus.Minder.get(minder, :uuid12312)
    assert Enum.member?(reminders, "buy coffee")
    assert Enum.member?(reminders, "walk dog")
    refute Enum.member?(reminders, "don't exist")
  end
end

