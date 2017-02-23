defmodule Accounts.Handler do
  use GenServer

  # Public API

  def start_link(name \\ AccountHandler) do
    GenServer.start_link(__MODULE__, :ok, [name: name])
  end

  def create(server, username, email, password) do
    GenServer.call(server, {:create, username, email, password})
  end

  def login(server, username, password) do
    GenServer.call(server, {:login, username, password})
  end

  # Server callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:login, username, password}, _from, state) do
    case Accounts.Account.login(username, password) do
      {:ok, session}  -> {:reply, {:ok, %{access_token: session.access_token}}, state}
      {:error, error} -> {:reply, {:error, error}, state}
    end
  end

  def handle_call({:create, username, email, password}, _from, state) do
    case Accounts.Account.create(username, email, password) do
      {:ok, account}  -> {:reply, {:ok, account}, state}
      {:error, error} -> {:reply, {:error, error}, state}
    end
  end
end

