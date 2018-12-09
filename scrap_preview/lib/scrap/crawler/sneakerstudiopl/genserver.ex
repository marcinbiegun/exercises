defmodule Scrap.Crawler.Sneakerstudiopl.GenServer do
  @behaviour Scrap.Behaviour.WebCrawler

  @request_sleep 10
  @cycle_sleep 5000

  use GenServer
  require Logger
  alias Scrap.Helper.Web
  alias Scrap.Crawler.Sneakerstudiopl.Source
  alias Scrap.Storage

  @impl true
  def initial_queue do
    Source.index_page_jobs
  end

  @impl true
  def start_link do
    log :info, "starting."
    GenServer.start_link(__MODULE__, initial_queue())
  end

  @impl true
  def init(queue) do
    schedule_work()
    {:ok, queue}
  end

  @impl true
  def handle_info(:work, []) do
    log :info, "queue is empty. Scheduling initial queue and pausing."

    schedule_work(:pause)
    {:noreply, initial_queue()}
  end

  @impl true
  def handle_info(:work, queue) do
    [head | tail] = queue
    new_queue = process(head, tail)
    schedule_work()
    {:noreply, new_queue}
  end

  @impl true
  def schedule_work() do
    Process.send_after(self(), :work, @request_sleep)
  end

  def schedule_work(:pause) do
    Process.send_after(self(), :work, @cycle_sleep)
  end

  @impl true
  def process({:index_page, brand, url}, queue) do
    case Web.get(url) do
      %{status_code: 200, body: body} ->
        new_jobs = Source.find_jobs(:index_page, brand, url, body)
        log :info, "got index page: #{url}, adding #{length(new_jobs)} product_page jobs to queue"
        queue ++ new_jobs
      %{status_code: 302} ->
        log :info, "no more index pages for: #{url}"
        queue
    end
  end

  @impl true
  def process({:product_page, brand, url}, queue) do
    log :info, "getting product page: #{url}"

    %{status_code: 200, body: body} = Web.get(url)
    Source.read_product(brand, url, body) |> store_product

    queue
  end

  @impl true
  def store_product(data) do
    case Storage.create_offer_point(data) do
      {:error, changeset} ->
        log :error, "failed to store product: #{inspect(data)}"
        log :error, "errors: #{changeset.errors}"
        changeset
      {:ok, changeset} ->
        log :info, "saved product: #{inspect(data)}"
        changeset
    end
  end

  defp log(:info, msg) do
    Logger.info "Sneakerstudiopl.GenServer | #{msg}"
  end

  defp log(:error, msg) do
    Logger.error "Sneakerstudiopl.GenServer | #{msg}"
  end
end
