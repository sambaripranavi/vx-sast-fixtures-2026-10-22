defmodule FixtureAppWeb.SafeController do
  # Benign lookalikes: same APIs as VulnController, used safely.
  use Phoenix.Controller, formats: [:html]
  import Ecto.Query
  alias FixtureApp.{Repo, User}

  @reports_dir "/srv/reports"
  @allowed_files %{"terms" => "/srv/static/terms.txt"}

  # FX-BEGIN EX-B01
  def sqli(conn, %{"name" => name}) do
    users = Repo.all(from u in User, where: u.name == ^name, select: u.name)
    json(conn, users)
  end
  # FX-END EX-B01

  # FX-BEGIN EX-B02
  def cmd(conn, _params) do
    {out, _} = System.cmd("ls", ["-l", @reports_dir])
    text(conn, out)
  end
  # FX-END EX-B02

  # FX-BEGIN EX-B03
  def atom(conn, %{"kind" => kind}) do
    text(conn, inspect(String.to_existing_atom(kind)))
  end
  # FX-END EX-B03

  # FX-BEGIN EX-B04
  def file(conn, %{"name" => name}) do
    case Map.fetch(@allowed_files, name) do
      {:ok, path} -> send_file(conn, 200, path)
      :error -> send_resp(conn, 404, "not found")
    end
  end
  # FX-END EX-B04

  # FX-BEGIN EX-B05
  def state(conn, %{"data" => data}) do
    term = :erlang.binary_to_term(Base.decode64!(data), [:safe])
    text(conn, inspect(term))
  end
  # FX-END EX-B05
end
