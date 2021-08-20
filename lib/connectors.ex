defmodule Connectors do

  def init() do
    pid = spawn_link(__MODULE__, :get_tweet, [])
    {:ok, _pid1} = EventsourceEx.new("localhost:4000/tweets/1", stream_to: pid)
    {:ok, _pid2} = EventsourceEx.new("localhost:4000/tweets/2", stream_to: pid)
    {:ok, self()}
  end

  def get_tweet() do
      receive do
        tweet -> GenServer.cast(Router, {:router, tweet})
      end
      get_tweet()
  end

  def child_spec(arg) do
   %{
     id: __MODULE__,
     start: {__MODULE__, :start_link, [arg]},
     type: :worker,
     restart: :permanent
   }
 end

end
