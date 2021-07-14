defmodule Chatz.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Chatz.Repo,
      ChatzWeb.Telemetry,
      {Phoenix.PubSub, name: Chatz.PubSub},
      ChatzWeb.Endpoint,
      Pow.Store.Backend.MnesiaCache
    ]

    opts = [strategy: :one_for_one, name: Chatz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ChatzWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
