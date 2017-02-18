use Mix.Config

config :reminders, :ecto_repos, [Reminders.Repo]

import_config "#{Mix.env}.exs"
