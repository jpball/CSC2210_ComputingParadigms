# 3) Write a program with a single module that has a factorial
# function. The factorial function take a number and find
# the product of all of the numbers down to 1.
# Print out the current value of the number as you recurse through the function calls.

defmodule Factorial do
  def doFactorial(number) do
    factor_helper(number)
  end

  defp factor_helper(1) do
    1
  end

  defp factor_helper(number) do
    number * factor_helper(number - 1)
  end
end

IO.puts(Factorial.doFactorial(150))
