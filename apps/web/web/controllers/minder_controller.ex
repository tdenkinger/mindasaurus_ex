defmodule Web.MinderController do
  use Web.Web, :controller

  def show(conn, %{"id" => id}) do
    reminders = Domain.Minder.get(MinderMain, build_uuid(id))
    render conn, "show.json", reminders: reminders
  end

  def create(conn, %{"id" => id, "reminder" => reminder}) do
    status = Domain.Minder.create(MinderMain, build_uuid(id), reminder)
    render conn, "create.json", status: status
  end

  defp build_uuid(id), do: "#{id}"
end
