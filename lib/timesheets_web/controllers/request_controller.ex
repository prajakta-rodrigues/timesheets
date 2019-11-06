defmodule TimesheetsWeb.RequestController do
  use TimesheetsWeb, :controller

  alias Timesheets.Requests
  alias Timesheets.Requests.Request

  def index(conn, _params) do
    requests = Requests.list_requests()
    render(conn, "index.html", requests: requests)
  end

  def new(conn, _params) do
    changeset = Requests.change_request(%Request{})
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
    IO.puts("In show")
    IO.inspect(conn)
    request = Requests.get_request!(id)
    changeset = Requests.change_request(request)
    render(conn, "show.html", request: request, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    request = Requests.get_request!(id)
    IO.puts("in edit")
    IO.inspect(request)
    request = Map.put(request, :approval, true)
    changeset = Requests.change_request(request)
    case Requests.update_request(request) do
      {:ok, _} ->
        IO.puts("step ahead")
        conn
        |> put_flash(:info, "Request approved successfully.")
        |> redirect(to: Routes.request_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts("Some error occured")
        render(conn, "show.html", request: request, changeset: changeset)
    end

    # changeset = Requests.change_request(request)
    # render(conn, "edit.html", request: request, changeset: changeset)
  end

  def update(conn, %{"id" => id, "request" => attrs}) do
    IO.puts("hti")
    request = Requests.get_request!(id)
    # request = Map.put(request, :approval, req.approval)
    IO.inspect(request)
    IO.puts("out here")
    case Requests.update_request(request, attrs) do
      {:ok, request} ->
        conn
        |> put_flash(:info, "Request updated successfully.")
        |> redirect(to: Routes.request_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts("Some error occured")
        render(conn, "show.html", request: request, changeset: changeset)
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
