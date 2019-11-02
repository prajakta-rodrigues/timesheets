defmodule Timesheets.Requests.Request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "requests" do
    field :manager_id, :integer
    belongs_to :user, Timesheets.Users.User
    field :date, :date
    field :approved, :boolean

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:user_id, :manager_id, :date])
    |> validate_required([:user_id, :manager_id, :date])
  end
end
