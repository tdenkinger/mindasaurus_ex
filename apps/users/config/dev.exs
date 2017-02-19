use Mix.Config

config :users, Users.Repo,[
  adapter: Ecto.Adapters.Postgres,
  database: "reminders_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
]
