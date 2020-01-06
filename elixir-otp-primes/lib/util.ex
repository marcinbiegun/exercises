defmodule Primes.Util do
  require Integer

  def is_whole_number?(number) when is_float(number) do
    case Float.ratio(number) do
      {_, 1} -> true
      _ -> false
    end
  end

  def pow(_, 0), do: 1
  def pow(x, n) when Integer.is_odd(n), do: x * pow(x, n - 1)
  def pow(x, n) do
    result = pow(x, div(n, 2))
    result * result
  end
end
