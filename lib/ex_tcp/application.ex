defmodule ExTcp.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: ExTcp.TaskSupervisor},
      Supervisor.child_spec({Task, fn -> ExTcp.Server.listen(4000) end}, restart: :permanent)
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ExTcp.Supervisor)
  end
end
