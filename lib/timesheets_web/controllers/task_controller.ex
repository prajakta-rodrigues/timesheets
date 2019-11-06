defmodule TimesheetsWeb.TaskController do
  use TimesheetsWeb, :controller

  alias Timesheets.Tasks
  alias Timesheets.Tasks.Task
  alias Timesheets.Requests

  def index(conn,  %{"request_id" => request_id}) do
    tasks = Tasks.list_tasks_by_request_id(request_id)
    request = Requests.get_request!(request_id)
    IO.inspect(Tasks.list_tasks_by_request_id(request_id))
    render(conn, "index.html", tasks: tasks, request_id: request_id, request: request)
  end

  def new(conn,   %{"request_id" => request_id}) do
    IO.puts("request id is:")
    IO.puts(request_id)
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset, request_id: request_id)
  end

  def create(conn, %{"task" => task_params}) do
    IO.puts("In create")
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
