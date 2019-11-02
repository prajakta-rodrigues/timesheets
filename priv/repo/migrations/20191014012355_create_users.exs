defmodule Timesheets.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :role, :string, null: false
      add :manager_id, :integer
      timestamps()
    end

  end
end
