# FX-BEGIN EX-C01
defmodule FixtureAppWeb.CleanController do
  # Clean control: no security-relevant behaviour.
  use Phoenix.Controller, formats: [:html]

  def index(conn, _params) do
    text(conn, "Total: #{Enum.sum([1, 2, 3])}")
  end
end
# FX-END EX-C01
