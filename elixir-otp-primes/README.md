# Primes

What it should do:

```elixir
CalcPrime.is_prime?(9)
"9 is a prime number"
```

If you run a long calculion, then a quick one, the long one should run
in the background, not blocking another calculations. Like this:

```elixir
CalcPrime.is_prime?(67280421310721)
CalcPrime.is_prime?(9)
"9 is a prime number"
"67280421310721 is a prime number"
```

## Resources

List of a few large prime numbers: https://en.wikipedia.org/wiki/Largest_known_prime_number

