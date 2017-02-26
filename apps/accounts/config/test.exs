use Mix.Config

config :accounts, Accounts.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "reminders_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1
