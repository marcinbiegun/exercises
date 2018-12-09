defmodule Scrap.Crawler.Dummy.GenServer do
  @name "Dummy.GenServer"
  @request_sleep 10
  @cycle_sleep 1000

  use GenServer
  require Logger

  def initial_queue do
    [
      {:index_page, :nike, "indexpage_0"},
      {:index_page, :nike, "indexpage_1"},
      {:index_page, :nike, "indexpage_2"}
    ]
  end

  def start_link do
    Logger.info "#{@name} starting GenServer."
    GenServer.start_link(__MODULE__, initial_queue())
  end

  def init(queue) do
    schedule_work()
    {:ok, queue}
  end

  def handle_info(:work, []) do
    Logger.info "#{@name} queue is empty. Scheduling initial queue and pausing."
    schedule_work(:pause)
    {:noreply, initial_queue()}
  end

  def handle_info(:work, queue) do
    [head | tail] = queue
    new_queue = process(head, tail)
    schedule_work()
    {:noreply, new_queue}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, @request_sleep)
  end

  defp schedule_work(:pause) do
    Process.send_after(self(), :work, @cycle_sleep)
  end

  defp process({:index_page, brand, url}, queue) do
    new_jobs = (1..5) |> Enum.map(fn i ->
      {:product_page, brand, "#{url}_product#{i}"}
    end)
    Logger.info "#{@name} got index page: #{url}, adding #{length(new_jobs)} product_page jobs to queue"
    queue ++ new_jobs
  end

  defp process({:product_page, _, url}, queue) do
    Logger.info "#{@name} getting product page: #{url}"
    queue
  end
end
