defmodule MarsWater.Util.MaxHeap do
  alias MarsWater.Util.MaxHeap
  defstruct list: {}, size: 0

  # Unused first element to simplify getting parent / child
  @max_priority 999_999_999
  def new() do
    %MaxHeap{list: {{@max_priority, nil}}, size: 0}
  end

  def insert(%MaxHeap{list: list, size: size}, {priority, _data} = elem) do
    if (priority >= @max_priority) do
      raise "Priority needs to be smaller than #{@max_priority}"
    end
    new_list = Tuple.append(list, elem)
    new_size = size + 1
    new_list = rebalance_list_up(new_list, new_size)
    %MaxHeap{list: new_list, size: new_size}
  end

  def delete_root(%MaxHeap{list: list, size: size}) do
    value = list |> elem(1)
    new_list = replace_at(list, 1, elem(list, size))
    new_list = Tuple.delete_at(new_list, size)
    new_size = size - 1
    new_heap = rebalance_heap_down(%MaxHeap{list: new_list, size: new_size}, 1)
    {value, new_heap}
  end

  def rebalance_list_up(list, i) do
    if i == 0 do
      list
    else
      new_list = if elem_priority(list, i) > elem_priority(list, parent(i)) do
        swap(list, i, parent(i))
      else
        list
      end
      rebalance_list_up(new_list, parent(i))
    end
  end

  def rebalance_heap_down(%MaxHeap{list: list, size: size} = heap, i) do
    if i > size do
      heap
    else
      larger_child = larger_child(heap, i)
      new_list = cond do
        larger_child > size ->
          list
        elem_priority(list, i) < elem_priority(list, larger_child) ->
          swap(list, i, larger_child)
        true ->
          list
      end
      new_heap = %MaxHeap{list: new_list, size: size}
      rebalance_heap_down(new_heap, larger_child)
    end
  end

  def larger_child(%MaxHeap{list: list, size: size}, i) do
    if right_child(i) > size do
      left_child(i)
    else
      if elem_priority(list, left_child(i)) > elem_priority(list, right_child(i)) do
        left_child(i)
      else
        right_child(i)
      end
    end
  end

  def elem_priority(list, i) do
    list |> elem(i) |> elem(0)
  end

  def parent(i) do
    div(i , 2)
  end

  def left_child(i) do
    i * 2
  end

  def right_child(i) do
    i * 2 + 1
  end

  def swap(list, i, j) do
    i_value = elem(list, i)
    j_value = elem(list, j)
    list
    |> replace_at(i, j_value)
    |> replace_at(j, i_value)
  end

  def replace_at(tuple, index, value) do
    Tuple.insert_at(tuple, index, value)
    |> Tuple.delete_at(index + 1)
  end
end
