defmodule Primes.Calc do
  alias Primes.Util

  def is_prime?(number) when number in [0, 1], do: false

  def is_prime?(number) when number == 2, do: true

  def is_prime?(number) when number >= 3 do
    2..number-1 |> Enum.any?(& Util.is_whole_number?(number / &1))
  end
end
