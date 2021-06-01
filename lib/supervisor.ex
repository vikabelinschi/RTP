defmodule DySupervisor do
  use DynamicSupervisor

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def addWorker(tweet) do
    spec = {Worker, {tweet}}
    DynamicSupervisor.start_child(__MODULE__, spec)
        GenServer.cast(Worker, {:worker, tweet})
  end

  def killWorker(worker_pid) do
    DynamicSupervisor.terminate_child(__MODULE__, worker_pid)
  end
end
