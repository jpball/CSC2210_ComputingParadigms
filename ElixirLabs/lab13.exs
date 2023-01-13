





# Make sure to account for odd group sizes. For example, I
#   should be able to break the values into groups of 5 and it should round
#   correctly (0, 1, 2 round down, 3, 4 round up).

# Then create another function that takes in a starting
#   and ending value along with a grouping size and return a collection of
#   values rounded to the correct value:



defmodule RangeHelper do

  # Include a function called abs_all that accepts a
  # start and end value that uses Enum.map to create a
  # new collection with absolute values:
  def abs_all(start_val, end_val) do
    Enum.map(start_val..end_val, &abs_val/1)
  end

  def abs_val(val) when val < 0 do
    (val * -1)
  end

  def abs_val(val) do
    val
  end

  # Next, write a function that will return a collection
  #   of either evens or odds within a starting and ending value:
  # RangeHelper.evens_odds(1, 5, "even") #[2, 4]
  def evens_odds(start_val, end_val, "even") do
    Enum.filter(start_val..end_val, fn(val) -> rem(val, 2) === 0 end)
  end

  def evens_odds(start_val, end_val, "odd") do
    Enum.filter(start_val..end_val, fn(val) -> rem(val, 2) !== 0 end)
  end

  # Finally, include a function called round_to_nearest/2
  #   that will round a number to a nearest multiple of a number:

  def round_to_nearest(number, multiple) do
    round_helper(number, rem(number, multiple), multiple)
  end

  defp round_helper(number, remainder, target) when remainder < target - remainder do
    number - remainder
  end

  defp round_helper(number, remainder, target) do
    number + (target - remainder)
  end

  # Then create another function that takes in a
  # starting and ending value along with a grouping
  # size and return a collection of values rounded to the correct value:
  def round_all(start_val, end_val, target) do
    Enum.map(start_val..end_val, fn(val) -> round_to_nearest(val, target) end)
  end
end

RangeHelper.round_all(12, 22, 5) |> IO.inspect #[10, 15, 15, 15, 15, 15, 20, 20, 20, 20, 20]

# IO.inspect(RangeHelper.abs_all(-5, 5))
# IO.inspect(RangeHelper.evens_odds(1, 5, "even")) #[2, 4]
# IO.inspect(RangeHelper.evens_odds(1, 5, "odd")) #[1, 3, 5]

# RangeHelper.round_to_nearest(44, 10) |> IO.inspect #returns 40
# RangeHelper.round_to_nearest(45, 10) |> IO.inspect #returns 50
# RangeHelper.round_to_nearest(46, 10) |> IO.inspect #returns 50
# RangeHelper.round_to_nearest(44, 100) |> IO.inspect #returns 0
# RangeHelper.round_to_nearest(45, 100) |> IO.inspect #returns 0
# RangeHelper.round_to_nearest(46, 100) |> IO.inspect #returns 0
# RangeHelper.round_to_nearest(6, 5) |> IO.inspect
