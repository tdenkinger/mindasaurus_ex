defmodule Accounts.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Accounts.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: Accounts.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
