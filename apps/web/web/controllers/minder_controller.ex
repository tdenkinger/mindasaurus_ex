defmodule Web.MinderController do
  use Web.Web, :controller

  def show(conn, %{"id" => access_token}) do
    reminders = Reminders.Gateway.get(Gateway, access_token)
    render conn, "show.json", reminders: reminders
  end

  def create(conn, %{"id" => access_token, "reminder" => reminder}) do
    status = Reminders.Gateway.create(Gateway, access_token, reminder)
    render conn, "create.json", status: status
  end

  def delete(conn, %{"id" => reminder_id, "access_token" => access_token}) do
    case Reminders.Gateway.delete(Gateway, access_token, reminder_id) do
      {:ok, reminder} ->
        render conn, "delete.json", status: :ok, message: reminder.reminder
      {:error, error} ->
        render conn, "delete.json", status: :error, message: error
    end
  end
end

