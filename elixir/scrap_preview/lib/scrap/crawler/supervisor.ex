defmodule Scrap.Crawler.Supervisor do
  use Supervisor
  require Logger

  alias Scrap.Crawler.Sneakerstudiopl

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = case Application.get_env(:scrap, :run_crawlers) do
      true ->
        [
          #worker(Scrap.Crawler.Dummy.GenServer, [])
          worker(Sneakerstudiopl.GenServer, [])
        ]
      false ->
        []
    end

    supervise(children, strategy: :one_for_one)
  end
end
