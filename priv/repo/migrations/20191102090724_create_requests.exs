defmodule Timesheets.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :approval, :boolean, default: false, null: false
      add :date, :date
      add :user_id, references(:users, on_delete: :nothing)
      add :manager_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:requests, [:user_id])
    create index(:requests, [:manager_id])
  end
end
