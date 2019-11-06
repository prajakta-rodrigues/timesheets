defmodule Timesheets.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :job_code, :integer
    field :time_spent, :time
    belongs_to :request, Timesheets.Requests.Request
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:job_code, :time_spent, :request_id])
    |> validate_required([:job_code, :time_spent, :request_id])
  end
end
