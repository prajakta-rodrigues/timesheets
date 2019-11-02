defmodule Timesheets.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    belongs_to :assigns, Timesheets.Jobs.Job
    field :time_spent, :time
    belongs_to :request, Timesheets.Requests.Request
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:assigns_id, :time_spent, :request_id])
    |> validate_required([:assigns_id, :time_spent, :request_id])
  end
end
