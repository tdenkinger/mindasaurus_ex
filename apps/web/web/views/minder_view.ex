defmodule Web.MinderView do
  use Web.Web, :view

  def render("show.json", %{reminders: reminders}) do
    %{
      reminders: reminders
    }
  end

  def render("create.json", %{status: status}) do
    %{
      status: status
    }
  end
end
