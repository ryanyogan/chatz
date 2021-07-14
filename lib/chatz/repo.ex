defmodule Chatz.Repo do
  use Ecto.Repo,
    otp_app: :chatz,
    adapter: Ecto.Adapters.Postgres
end
