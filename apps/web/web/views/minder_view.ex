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

  defp reminder_json({id, reminder}) do
    %{id: id, reminder: reminder}
  end
end
