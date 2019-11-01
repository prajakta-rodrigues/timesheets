use Mix.Config

# Configure your database
config :timesheets, Timesheets.Repo,
  username: "timesheets",
  password: "timesheets",
  database: "Timesheets_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :timesheets, TimesheetsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
