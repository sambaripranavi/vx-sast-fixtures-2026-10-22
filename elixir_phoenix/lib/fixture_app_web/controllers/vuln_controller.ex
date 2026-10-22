defmodule FixtureAppWeb.VulnController do
  # Known-vulnerable benchmark cases.
  use Phoenix.Controller, formats: [:html]
  alias FixtureApp.Repo

  # FX-BEGIN EX-V01
  def sqli(conn, %{"name" => name}) do
    {:ok, result} = Ecto.Adapters.SQL.query(Repo, "SELECT * FROM users WHERE name = '#{name}'", [])
    json(conn, result.rows)
  end
  # FX-END EX-V01

  # FX-BEGIN EX-V02
  def cmd(conn, %{"host" => host}) do
    {out, _} = System.cmd(host, [])
    text(conn, out)
  end
  # FX-END EX-V02

  # FX-BEGIN EX-V03
  def hello(conn, %{"name" => name}) do
    html(conn, "<h1>Hello #{name}</h1>")
  end
  # FX-END EX-V03

  # FX-BEGIN EX-V04
  def file(conn, %{"name" => name}) do
    send_file(conn, 200, "/srv/data/" <> name)
  end
  # FX-END EX-V04

  # FX-BEGIN EX-V05
  def atom(conn, %{"kind" => kind}) do
    text(conn, inspect(String.to_atom(kind)))
  end
  # FX-END EX-V05

  # FX-BEGIN EX-V06
  def state(conn, %{"data" => data}) do
    term = :erlang.binary_to_term(Base.decode64!(data))
    text(conn, inspect(term))
  end
  # FX-END EX-V06
end
