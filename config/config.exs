# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chatz,
  ecto_repos: [Chatz.Repo]

# Configures the endpoint
config :chatz, ChatzWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yaFXXn4GuNLmxviBlUGvXNVJ5ha8HvHlC5CYO9vXBVS0JLaKpL9Gae8HeLqootHC",
  render_errors: [view: ChatzWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Chatz.PubSub,
  live_view: [signing_salt: "TR+pNvrx"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
