# Write an Elixir program that includes a
# function that takes a list of numbers and collects and returns only the even ones.


defmodule EvensModule do

  def collect_evens(nums) do
    collect_evens_helper(nums, MapSet.new)
  end

  def collect_evens_helper([], set) do
    MapSet.to_list(set)
  end

  def collect_evens_helper([head | rest], set) when rem(head, 2) == 0 do
    collect_evens_helper(rest, MapSet.put(set, head))
  end

  def collect_evens_helper([_head | rest], set) do
    collect_evens_helper(rest, set)
  end
end


nums = [3, 12, 9, 7, 33, 34, 12, 6]
even_nums = EvensModule.collect_evens(nums) #[12, 34, 6]
IO.inspect(even_nums)
