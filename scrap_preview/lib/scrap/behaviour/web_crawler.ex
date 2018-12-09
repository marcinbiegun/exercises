defmodule Scrap.Behaviour.WebCrawler do
  @moduledoc """
  Checks if all web crawler GenServers have all required functions defined.
  """

  @type index_job :: {:index_page, atom, String.t}
  @type product_job :: {:product_page, atom, String.t}
  @type jobs_list :: [index_job | product_job]

  @callback initial_queue() :: [index_job]
  @callback start_link() :: any
  @callback schedule_work() :: any
  @callback process(index_job, jobs_list) :: jobs_list
  @callback process(product_job, jobs_list) :: jobs_list
  @callback store_product(struct) :: struct
end
