use Mix.Config

config :chatz,
  ecto_repos: [Chatz.Repo]

config :chatz, ChatzWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yaFXXn4GuNLmxviBlUGvXNVJ5ha8HvHlC5CYO9vXBVS0JLaKpL9Gae8HeLqootHC",
  render_errors: [view: ChatzWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Chatz.PubSub,
  live_view: [signing_salt: "TR+pNvrx"]

config :chatz, :pow,
  user: Chatz.Auth.User,
  repo: Chatz.Repo,
  web_module: ChatzWeb

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
