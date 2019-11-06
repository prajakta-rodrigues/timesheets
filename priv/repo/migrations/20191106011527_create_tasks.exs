defmodule Timesheets.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :job_code, :integer, null: false
      add :time_spent, :time
      add :request_id, references(:requests, on_delete: :delete_all), null: false
      timestamps()
    end

    create index(:tasks, [:request_id])
  end
end
