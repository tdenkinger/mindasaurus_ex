defmodule Web.AccountController do
  use Web.Web, :controller

  def create(conn, %{"username" => username, "email" => email, "password" => password}) do
    {:ok, account} = Accounts.Handler.create(AccountHandler, username, email, password)
    render conn, "create.json", account
  end
end

