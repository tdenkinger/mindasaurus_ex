defmodule Reminders.Minder do
  use GenServer

  # Public API

  def start_link(name \\ MinderMain) do
    GenServer.start_link(__MODULE__, :ok, [name: name])
  end

  def create(server, key, value), do: GenServer.call(server, {:create, key, value})
  def get(server, key), do: GenServer.call(server, {:get, key})

  # Server callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:create, access_token, new_reminder}, _from, state) do
    case Data.Reminder.save(access_token, new_reminder) do
      {:ok, _reminder} -> {:reply, :ok, state}
      {:error, error}  -> {:reply, {:error, error}, state}
       _               -> {:reply, :error, state}
    end
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Data.Reminder.get(key), state}
  end
end

