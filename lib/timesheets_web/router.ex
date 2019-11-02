defmodule TimesheetsWeb.Router do
  use TimesheetsWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(TimesheetsWeb.Plugs.FetchCurrentUser)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :ajax do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(TimesheetsWeb.Plugs.FetchCurrentUser)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope "/", TimesheetsWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/users", UserController)
    resources("/sessions", SessionController, only: [:new, :create, :delete], singleton: true)
    resources("/requests", RequestController)
    resources("/tasks", TaskController)
  end

  scope "/ajax", TimesheetsWeb do
    pipe_through(:ajax)
  end
end
