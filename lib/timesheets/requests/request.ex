defmodule Timesheets.Requests.Request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "requests" do
    field :approval, :boolean, default: false
    field :date, :date
    field :user_id, :id
    field :manager_id, :id

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:approval, :date, :user_id, :manager_id])
    |> validate_required([:approval, :date, :user_id, :manager_id])
  end

  @doc false
  def update(request) do
    request = Map.put(request, :approval, true)
    IO.inspect(request)
    request
  end
end
