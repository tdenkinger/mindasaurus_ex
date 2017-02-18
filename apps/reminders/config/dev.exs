use Mix.Config

config :reminders, Reminders.Repo,[
  adapter: Ecto.Adapters.Postgres,
  database: "reminders_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
]
