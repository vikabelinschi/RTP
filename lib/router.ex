defmodule Router do
  use GenServer

  def start_link(tweet) do
    GenServer.start_link(__MODULE__, tweet, name: __MODULE__)
  end

  @impl true
  def init(tweet) do
    {:ok, tweet}
  end

  @impl true
  def handle_cast({:router, tweet}, _states) do
    DySupervisor.addWorker(tweet)
    GenServer.cast(Sink, {:tweet, tweet})
    {:noreply, %{}}
 end


end
