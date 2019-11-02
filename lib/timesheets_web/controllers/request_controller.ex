defmodule TimesheetsWeb.RequestController do
  use TimesheetsWeb, :controller

  alias Timesheets.Requests
  alias Timesheets.Requests.Request

  def index(conn, _params) do
    changeset = Requests.change_request(%Request{})
    requests = Requests.list_requests()
    render(conn, "index.html", changeset: changeset, requests: requests)
  end

  def new(conn, _params, %{"user_id" => id, "manager_id" => manager_id}) do
    changeset = Requests.change_request(%Request{})
    IO.puts("here")
    IO.inspect(conn)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"request" => request_params}) do
    case Requests.create_request(request_params) do
      {:ok, request} ->
        conn
        |> put_flash(:info, "Request created successfully.")
        |> redirect(to: Routes.request_path(conn, :show, request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    request = Requests.get_request!(id)
    tasks = Tasks.get_tasks_by_request_id(id)
    render(conn, "show.html", request: request, tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    request = Requests.get_request!(id)
    changeset = Requests.change_request(request)
    render(conn, "edit.html", request: request, changeset: changeset)
  end

  def update(conn, %{"id" => id, "request" => request_params}) do
    request = Requests.get_request!(id)

    case Requests.update_request(request, request_params) do
      {:ok, request} ->
        conn
        |> put_flash(:info, "Request updated successfully.")
        |> redirect(to: Routes.request_path(conn, :show, request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", request: request, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    request = Requests.get_request!(id)
    {:ok, _request} = Requests.delete_request(request)

    conn
    |> put_flash(:info, "Request deleted successfully.")
    |> redirect(to: Routes.request_path(conn, :index))
  end
end
