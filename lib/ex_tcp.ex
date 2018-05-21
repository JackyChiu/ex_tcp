defmodule ExTcp do
  use Application

  def start(_type, _args) do
    children = [
      {Task, fn -> ExTcp.Server.listen(4000) end}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ExTcp.Supervisor)
  end
end
