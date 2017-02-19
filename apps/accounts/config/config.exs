use Mix.Config

config :accounts, :ecto_repos, [Users.Repo]

import_config "#{Mix.env}.exs"
