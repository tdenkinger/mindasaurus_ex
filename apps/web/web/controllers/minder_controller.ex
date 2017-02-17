defmodule Web.MinderController do
  use Web.Web, :controller

  def show(conn, %{"id" => id}) do
    reminders = Reminders.Minder.get(MinderMain, id)
    render conn, "show.json", reminders: reminders
  end

  def create(conn, %{"id" => id, "reminder" => reminder}) do
    status = Reminders.Minder.create(MinderMain, id, reminder)
    render conn, "create.json", status: status
  end
end

