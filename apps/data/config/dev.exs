use Mix.Config

config :data, Data.Repo,[
  adapter: Ecto.Adapters.Postgres,
  database: "reminders_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
]
