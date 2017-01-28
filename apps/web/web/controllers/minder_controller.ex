defmodule Web.MinderController do
  use Web.Web, :controller

  def index(conn, _params) do
    Mindasaurus.Minder.get(MinderMain, :uuid1234)
    render conn, "index.json"
  end
end
