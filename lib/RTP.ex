defmodule RTP do

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      %{
        id: Worker,
        start: {Worker, :start_link, [""]}
      },
      %{
        id: DySupervisor,
        start: {DySupervisor, :start_link, [""]}
      },
      %{
        id: Router,
        start: {Router, :start_link, [""]}
      },
      %{
        id: Connection,
       start: {Connection, :init, []}
     }
    ]

    opts = [strategy: :one_for_one, name: RTP.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
