defmodule Web.MinderView do
  use Web.Web, :view

  def render("show.json", %{reminders: reminders}) do
    %{
      reminders: Enum.map(reminders, &reminder_json/1)
    }
  end

  def render("create.json", %{status: status}) do
    %{
      status: status
    }
  end

  def render("delete.json", %{status: status, message: message}) do
    %{
      status: status,
      message: message
    }
  end

  defp reminder_json(%{id: id, reminder: reminder}) do
    %{id: id, reminder: reminder}
  end
end
