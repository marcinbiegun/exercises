defmodule Flatten do
  @doc """
  Given a list, returns a new list that is (recursively) flattened.

  ## Example
    iex> Flatten.flatten([1, [2, 3]])
    [1, 2, 3]
    iex> Flatten.flatten([1, [2, [3]]])
    [1, 2, 3]
  """
  def flatten(list) when is_list(list) do
    list |> Enum.reduce([], fn el, acc ->
      if is_list(el) do
        acc ++ flatten(el)
      else
        acc ++ [el]
      end
    end)
  end
end
