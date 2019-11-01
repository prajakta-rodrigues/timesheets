defmodule TimesheetsWeb.PageController do
  use TimesheetsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", photos: [1, 2, 3])
  end
end
