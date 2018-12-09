defmodule Scrap.Helper.Web do
  @timeout 10_000

  @spec get(String.t) :: %HTTPotion.Response{}
  def get(url) do
    HTTPotion.get(url, [timeout: @timeout])
  end
end

