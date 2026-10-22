defmodule FixtureAppWeb.Router do
  use Phoenix.Router

  # FX-BEGIN EX-V08
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
  end
  # FX-END EX-V08

  scope "/", FixtureAppWeb do
    pipe_through :browser
    get "/sqli", VulnController, :sqli
    get "/cmd", VulnController, :cmd
    get "/hello", VulnController, :hello
    get "/file", VulnController, :file
    get "/atom", VulnController, :atom
    get "/state", VulnController, :state
    get "/safe/sqli", SafeController, :sqli
    get "/safe/cmd", SafeController, :cmd
    get "/safe/atom", SafeController, :atom
    get "/safe/file", SafeController, :file
    get "/clean", CleanController, :index
  end
end
