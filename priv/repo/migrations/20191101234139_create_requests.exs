defmodule Timesheets.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :manager_id, :integer
      add  :date, :date
      add :approved, :boolean, default: false
      timestamps()
    end

  end
end
