import Config

config :fixture_app, FixtureAppWeb.Endpoint, url: [host: "localhost"]

import_config "#{config_env()}.exs"
