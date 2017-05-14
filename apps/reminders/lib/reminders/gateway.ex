defmodule Reminders.Gateway do
  use GenServer

  # Public API

  def start_link(name \\ ReminderGateway) do
    GenServer.start_link(__MODULE__, :ok, [name: name])
  end

  def create(server, key, value), do: GenServer.call(server, {:create, key, value})
  def get(server, key), do: GenServer.call(server, {:get, key})

  def delete(server, access_token, reminder_id) do
    GenServer.call(server, {:delete, access_token, reminder_id})
  end

  # Server callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:create, access_token, new_reminder}, _from, state) do
    case Reminders.Reminder.save(access_token, new_reminder) do
      {:ok, _reminder} -> {:reply, :ok, state}
      {:error, error}  -> {:reply, {:error, error}, state}
       _               -> {:reply, :error, state}
    end
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Reminders.Reminder.get(key), state}
  end

  def handle_call({:delete, access_token, reminder_id}, _from, state) do
    case Reminders.Reminder.delete(access_token, reminder_id) do
      {:ok, reminder} -> {:reply, {:ok, reminder}, state}
      {:error, error} -> {:reply, {:error, error}, state}
      _               -> {:reply, :error, state}
    end
  end
end

