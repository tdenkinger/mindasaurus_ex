use Mix.Config

config :accounts, Accounts.Repo,[
  adapter: Ecto.Adapters.Postgres,
  database: "reminders_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
]
