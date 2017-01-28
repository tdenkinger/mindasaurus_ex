defmodule Web.MinderView do
  use Web.Web, :view

  def render("index.json", _) do
    %{
      test: "test too"
    }
  end
end
