defmodule Timesheets.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :code, :string
      add :name, :string

      timestamps()
    end

  end
end
