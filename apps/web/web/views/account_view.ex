defmodule Web.AccountView do
  use Web.Web, :view

  def render("create.json", account) do
    %{ access_token: account.access_token }
  end

  def render("show.json", account) do
    %{access_token: account.access_token}
  end
end

