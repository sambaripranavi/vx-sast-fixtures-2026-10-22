defmodule FixtureApp.Repo do
  use Ecto.Repo, otp_app: :fixture_app, adapter: Ecto.Adapters.Postgres
end
