defmodule Web.AccountController do
  use Web.Web, :controller

  def create(conn, %{"username" => username, "email" => email, "password" => password}) do
    {:ok, account} = Accounts.Handler.create(AccountHandler, username, email, password)
    render conn, "create.json", account
  end

  def show(conn, %{"username" => username, "password" => password}) do
    case Accounts.Handler.login(AccountHandler, username, password) do
      {:ok, account}      -> render conn, "show.json", account
      {:error, "no user"} -> json(conn, %{error: "401"})
    end
  end

end

