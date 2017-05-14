defmodule Web.AccountController do
  use Web.Web, :controller

  def create(conn, %{"username" => username, "email" => email, "password" => password}) do
    {:ok, account} = Accounts.Gateway.create(Gateway, username, email, password)
    render conn, "create.json", account
  end

  def show(conn, %{"username" => username, "password" => password}) do
    case Accounts.Gateway.login(Gateway, username, password) do
      {:ok, account}      -> render conn, "show.json", account
      {:error, "no user"} -> json(conn, %{error: "401"})
    end
  end

end

