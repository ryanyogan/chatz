defmodule Chatz.Auth.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "auth_users" do
    field :nickname, :string
    pow_user_fields()

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> cast(attrs, [:nickname])
    |> validate_required([:nickname])
    |> unique_constraint(:nickname)
  end
end
