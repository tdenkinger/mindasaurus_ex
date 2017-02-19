use Mix.Config

config :accounts, Accounts.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "reminders_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

