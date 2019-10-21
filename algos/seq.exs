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
    a |> Enum.reject(fn n ->
      b |> Enum.count(& &1 == n) |> is_prime?
    end)
  end

  # https://www.factmonster.com/math-science/mathematics/prime-numbers-facts-examples-table-of-all-up-to-1000
  def is_prime?(number) when number >= 0 do
    cond do
      number in [0, 1] -> false
      true -> bruteforce_is_prime?(number)
    end
  end

  def bruteforce_is_prime?(number) when number in [0,1,2], do: true

  def bruteforce_is_prime?(number) when number >= 3 do
    (2..number-1 |> Enum.find(& is_whole_number?(number / &1))) == nil
  end

  def is_whole_number?(number) do
    case Float.ratio(number) do
      {_, 1} -> true
      _ -> false
    end
  end
end

IO.inspect Seq.compute_c(a, b)
