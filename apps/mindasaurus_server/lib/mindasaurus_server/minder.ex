defmodule Mindasaurus.Minder do
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

  def handle_call({:create, key, value}, _from, values) do
    values =
    case Map.has_key?(values, key) do
      true  -> Map.put(values, key, [value | values[key]])
      false -> Map.put(values, key, [value])
    end

    {:reply, :ok, values}
  end

  def handle_call({:get, key}, _from, values) do
    {:reply, Map.get(values, key, []) ,values}
  end
end

