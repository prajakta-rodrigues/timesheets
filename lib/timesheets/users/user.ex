defmodule Timesheets.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:password_hash, :string)
    field(:role, :string)
    field(:manager_id, :integer)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :role, :password, :password_confirmation])
    |> validate_confirmation(:password)
    # too short
    |> validate_length(:password, min: 8)
    |> hash_password()
    |> validate_required([:email, :name, :role, :password_hash])
  end

  def hash_password(cset) do
    pw = get_change(cset, :password)

    if pw do
      change(cset, Argon2.add_hash(pw))
    else
      cset
    end
  end
end
