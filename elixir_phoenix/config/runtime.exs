import Config

# FX-BEGIN EX-B06
config :fixture_app, FixtureAppWeb.Endpoint,
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")
# FX-END EX-B06
