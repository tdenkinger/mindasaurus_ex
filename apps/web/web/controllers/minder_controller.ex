defmodule Web.MinderController do
  use Web.Web, :controller

  def show(conn, %{"id" => id}) do
    reminders = Domain.Minder.get(MinderMain, id)
    render conn, "show.json", reminders: reminders
  end

  def create(conn, %{"id" => id, "reminder" => reminder}) do
    status = Domain.Minder.create(MinderMain, id, reminder)
    render conn, "create.json", status: status
  end
end

