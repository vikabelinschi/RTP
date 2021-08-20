defmodule RTP do

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      %{
        id: Router,
        start: {Router, :start_link, []}
      },
      %{
        id: Connectors,
       start: {Connectors, :init, []}
     }
    ]

    opts = [strategy: :one_for_one, name: RTP.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
