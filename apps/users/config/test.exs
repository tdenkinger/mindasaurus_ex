use Mix.Config

config :users, Users.Repo,[
  adapter: Ecto.Adapters.Postgres,
  database: "reminders_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
]
