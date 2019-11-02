defmodule Timesheets.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :assigns_id, references(:jobs, on_delete: :delete_all)
      add :time_spent, :time
      add :request_id, references(:requests, on_delete: :delete_all)
      timestamps()
    end

  end
end
