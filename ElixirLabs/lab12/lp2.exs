# 2) Write a program with a single module that has two families of functions.
# One will count up from 1 to the passed in number and print each number.
# The other will count down from a number to 1 and print each number.
# Use recursion for these functions.

defmodule Counter do

  def count_down(1) do
    IO.puts(1)
  end

  def count_down(number) do
    IO.puts(number)
    count_down(number - 1)
  end

  def count_up(1) do
    IO.puts(1)
  end

  def count_up(number) do
    count_up(number - 1)
    IO.puts(number)
  end
end

Counter.count_up(5)
IO.puts("---------")
Counter.count_down(10)
