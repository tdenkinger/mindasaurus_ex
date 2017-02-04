use Mix.Config

config :data, Data.Repo,[
  adapter: Ecto.Adapters.Postgres,
  database: "data_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
]
