defmodule Primes.Link do
  alias Primes.SlowCalc

  def start_link do
    spawn_link(__MODULE__, :loop, [{MapSet.new, MapSet.new}])
  end

  def loop({primes, nonprimes} = _state) do
    receive do
      {:is_prime, number, pid} ->
        is_prime = cond do
          MapSet.member?(primes, number) ->
            true
          MapSet.member?(nonprimes, number) ->
            false
          true ->
            SlowCalc.is_prime?(number)
        end

        send(pid, {:is_prime, number, is_prime})

        if is_prime do
          primes = MapSet.put(primes, number)
        else
          nonprimes = MapSet.put(nonprimes, number)
        end

        new_state = {primes, nonprimes}
        loop(new_state)
    end
  end
end
