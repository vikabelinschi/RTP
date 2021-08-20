
defmodule Worker do
  use GenServer


  def start_link(index) do
      GenServer.start_link(__MODULE__, :ok, name: {:global, index})
    end

    def compute(tweet) do
      GenServer.cast(__MODULE__, {:compute, tweet})
    end

  @impl true
  def init(tweet) do
    {:ok, tweet}
  end

  @impl true
  def handle_cast({:compute, tweet}, _) do
    Decoder.print_tweet(tweet)
    {:noreply, %{}}
  end


end
