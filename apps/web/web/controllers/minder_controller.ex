defmodule Web.MinderController do
  use Web.Web, :controller

  def show(conn, %{"id" => access_token}) do
    reminders = Reminders.Minder.get(MinderMain, access_token)
    render conn, "show.json", reminders: reminders
  end

  def create(conn, %{"id" => access_token, "reminder" => reminder}) do
    status = Reminders.Minder.create(MinderMain, access_token, reminder)
    render conn, "create.json", status: status
  end
end

