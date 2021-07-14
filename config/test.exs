use Mix.Config

config :chatz, Chatz.Repo,
  username: "postgres",
  password: "postgres",
  database: "chatz_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :chatz, ChatzWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn

import_config "#{Mix.env()}.secret.exs"
