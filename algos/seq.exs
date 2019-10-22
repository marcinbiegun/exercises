#
# Select all from a
#    than occurs in b
#    not in an prime number count
# while keeping order
#

a = [2,3,9,2,5,1,3,7,10]
b = [2,1,3,4,3,10,6,6,1,7,10,10,10]

defmodule Seq do
  def compute_c(a, b) do
    cache = ListCounter.build_cache(b)
    {:ok, computor_pid} = GenServer.start_link(PrimeComputor, nil)
    a |> Enum.reject(fn n ->
      occurences = ListCounter.count(cache, n)
      GenServer.call(computor_pid, {:is_prime?, occurences})
    end)
  end
end

defmodule ListCounter do
  def build_cache(list) do
    {_list, cache} = list |> Enum.map_reduce(%{}, fn el, acc ->
      acc = Map.put(acc, el, Map.get(acc, el, 0) + 1)
      {el, acc}
    end)
    cache
  end

  def count(cache, el) do
    Map.get(cache, el, 0)
  end
end

defmodule Util do
  def is_whole_number?(number) when is_float(number) do
    case Float.ratio(number) do
      {_, 1} -> true
      _ -> false
    end
  end
end

defmodule PrimeHacks do
  require Integer

  # https://www.factmonster.com/math-science/mathematics/prime-numbers-facts-examples-table-of-all-up-to-1000

  def is_prime?(number) when is_integer(number) and number >= 0 do
    cond do
      number in [0, 1] -> false
      number == 2 -> true
      is_even?(number) -> false
      sum_of_digits_is_a_multiple_of_3?(number) -> false
      is_greater_than_5_and_ends_in_5?(number) -> false
      true -> nil
    end
  end

  def is_even?(number) do
    Integer.is_even(number)
  end

  def sum_of_digits_is_a_multiple_of_3?(number) do
    sum_of_digits = "#{number}" |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.sum
    Util.is_whole_number?(sum_of_digits / 3)
  end

  def is_greater_than_5_and_ends_in_5?(number) do
    if number <= 5 do
      false
    else
      last_digit = "#{number}" |> String.split("", trim: true) |> Enum.reverse |> hd |> String.to_integer
      last_digit == 5
    end
  end
end

defmodule PrimeComputor do
  use GenServer

  @impl true
  def init(nil) do
    primes = MapSet.new
    nonprimes = MapSet.new
    {:ok, {primes, nonprimes}}
  end

  @impl true
  def handle_call({:is_prime?, number}, _from, {primes, nonprimes}) do
    is_prime = cond do
      MapSet.member?(primes, number) -> true
      MapSet.member?(nonprimes, number) -> false
      PrimeHacks.is_prime?(number) == true -> true
      PrimeHacks.is_prime?(number) == false -> false
      true -> bruteforce_is_prime?(number)
    end

    primes = if is_prime == true, do: MapSet.put(primes, number), else: primes
    nonprimes = if is_prime == false, do: MapSet.put(nonprimes, number), else: nonprimes

    {:reply, is_prime, {primes, nonprimes}}
  end

  def bruteforce_is_prime?(number) when number in [0, 1], do: false

  def bruteforce_is_prime?(number) when number == 2, do: true

  def bruteforce_is_prime?(number) when number >= 3 do
    (2..number-1 |> Enum.find(& Util.is_whole_number?(number / &1))) == nil
  end
end

IO.inspect Seq.compute_c(a, b)
