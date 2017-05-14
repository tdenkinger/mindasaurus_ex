defmodule Reminders.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Reminders.Gateway, [ReminderGateway]),
      worker(Reminders.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: Reminders.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
