
defmodule FW do
  def fraction_to_s(map) do
    "#{map.numerator}/#{map.denominator}"
  end

  #Given a fraction, return a new fraction that is reduced as a map
  def reduceFraction(fraction) do
    gcd = get_gcd(fraction.numerator, fraction.denominator)
    IO.puts("GCD: #{gcd}")
    %{numerator: div(fraction.numerator, gcd), denominator: div(fraction.denominator, gcd)}
  end

  # One can find a reduced fraction by looking for the greatest common divisor.
  # This is calculated by finding the smaller of the numerator and denominator
  # and then working down to the number 1.
  # If any number in that range evenly divides both the
  # numerator and the denominator then that is the greatest common divisor.
  # If you get all the way to 1 then no number evenly divides both.
  # Write some functions to performs these calculations.
  def get_gcd(n1, n2) when n1 < n2 do
    gcd_helper(n1, n2, n1)
  end

  def get_gcd(n1, n2) when n1 > n2 do
    gcd_helper(n1, n2, n2)
  end

  def get_gcd(n1, _n2) do
    n1
  end

  def gcd_helper(_n1, _n2, 0) do
    1
  end

  def gcd_helper(n1, n2, counter) when rem(n1, counter) == 0 and rem(n2, counter) == 0 do
    counter
  end

  def gcd_helper(n1, n2, counter) do
    gcd_helper(n1, n2, counter - 1)
  end

  def printN(a, b, c) do
    IO.puts("#{a}   *   #{b}  [#{c}]")
  end

end

frac = %{numerator: 8056, denominator: 7144}
rf = FW.reduceFraction(frac)
IO.puts("OLD: #{FW.fraction_to_s(frac)}   NEW: #{FW.fraction_to_s(rf)}")
