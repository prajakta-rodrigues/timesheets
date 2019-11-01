defmodule TimesheetsWeb.LayoutView do
  use TimesheetsWeb, :view

  def nav_link(conn, text, path) do
    curr_path = "/" <> Enum.join(conn.path_info, "/")
    active = if curr_path == path do "active" else "" end
    raw ~s(
      <li class="nav-item #{active}">
        <a class="nav-link" href="#{path}">#{text}</a>
      </li>
    )
  end
end
