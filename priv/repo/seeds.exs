# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timesheets.Repo.insert!(%Timesheets.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Timesheets.Repo
alias Timesheets.Users.User


IO.inspect(Argon2.add_hash("password")[:password_hash])

pw = Argon2.add_hash("password")[:password_hash]

user1 = %User{id: 2, name: "Alice", email: "alice@example.com", role: "worker",
password_hash: pw, manager_id: 1}
user2 = %User{id: 1, name: "Joe", email: "joe@example.com", role: "manager",
password_hash: pw,}

Repo.insert!(user2)
Repo.insert!(user1)

