defmodule Worker do
  use GenServer


  def start_link(tweet) do
    GenServer.start(__MODULE__, tweet, name: __MODULE__)
  end

  @impl true
  def init(tweet) do
    {:ok, tweet}
  end

  @impl true
  def handle_cast({:worker, tweet}, _states) do
    Checker.print_tweet(tweet)
    {:noreply, %{}}
  end
end
