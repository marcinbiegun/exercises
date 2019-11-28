# MarsWater

This is a technical task I've got during a recruitment process.

## Task description

Your are given an input with is a string containing a number of digits
separated by spaces.

Sample input:

```
 3 4 2 6 2 6 0 2 3 0 0 2 8 8 9 2 1 4
```

The first digit is amount of results requested.

The second digit is size of grid.

The rest of digits fill the grid with measurements.

For each grid position, a score is calculated by summing the position
value and all neighbour values, so the total score is sum of 9 grid
positions.

You need to return the specified amount of top scored grid positions.

The scores outside of grid are 0.

For the example input, the solution would be:

```
 (2, 1, score: 37)
 (2, 2, score: 30)
 (3, 1, score: 27)
```

## Running the code

Run the tests:

```
mix test
```

Benchmarks the solutions performance:

```
mix run benchmark.exs
```


Profile the solutions (need the file to change the code that will be
profiled):

```
mix run profiler.ex
```

