# Create a module that represents a mathematical term.
# The module will have a function that returns a map with two key value pairs:
defmodule Term do
  # %{:coefficient => 1, :exponent => 2} #x^2
  # %{:coefficient => 3, :exponent => 1} #3x
  # %{:coefficient => 4, :exponent => 0} #4
  def get_term_map(coeff, expo) do
    %{:coefficient => coeff, :exponent => expo}
  end

  # The module will have a function to evaluate a term at any given x value.
  def eval_term(term, x_val) do
    term.coefficient * :math.pow(x_val, term.exponent)
  end

  # Also include a function that returns a string describing a term using the conventions above.
  def to_string(term) do
    "#{get_coef_str(term.coefficient)}#{get_expo_str(term.exponent)}"
  end

  defp get_coef_str(1) do
    # The coefficient is 1
    ""
  end

  defp get_coef_str(coefficient) do
    "#{coefficient}"
  end

  defp get_expo_str(0) do
    ""
  end
  defp get_expo_str(1) do
    "x"
  end
  defp get_expo_str(expo) do
    "x^#{expo}"
  end
end

# =========================================================================
defmodule MathFunction do
  # Function to add a new term to a list of terms,
  def add_term(coef, expo, func_so_far) do
    func_so_far ++ [Term.get_term_map(coef, expo)]
    |> Enum.sort(fn(t1, t2) -> t1[:exponent] >= t2[:exponent] end)
  end

  # Function to print a list of terms
  def to_string(list_of_terms) do
    Enum.map(list_of_terms, fn(term) ->
      # Convert each term of the function into it's string form
      Term.to_string(term)
    end)
    |> Enum.join(" + ")
  end

  # Function to evaluate all of the terms at a single x value
  def eval_func(list_of_terms, x_val) do
    eval_helper(x_val, list_of_terms, [])
  end

  defp eval_helper(x_val, [head | []], sofar) do
    sofar ++ [Term.eval_term(head, x_val)]
  end

  defp eval_helper(x_val, [head | rest], sofar) do
    eval_helper(x_val, rest, sofar ++ [Term.eval_term(head, x_val)])
  end
end

# =========================================================================
# Create a module called Integral that includes a function
#     to find the area under a curve.
# The simplest way to accomplish this is to create many,
#     many rectangles under the function.
# For each rectangle calculate the area and accumulate it.
# This value is an approximation of the area under the curve.
defmodule Integral do

  def evaluate(math_function, start_x, end_x, delta) do
    num_processes = System.schedulers_online()
    chunk_size = (end_x - start_x) / num_processes
    all_processes = []

    Enum.each(1..num_processes, fn(p_num) ->
      start_coord = start_x + (chunk_size * (p_num - 1))
      pid = spawn(Integral, :eval_worker, [self(), math_function, start_coord, start_coord + chunk_size, delta])
      all_processes ++ [pid]
    end)

    await_results(num_processes, [], all_processes)
  end

  defp await_results(0, results, all_processes) do
    Enum.each(all_processes, fn(pid) -> Process.exit(pid, :kill) end)
    results |> Enum.sum()
  end

  defp await_results(num_results, results, all_processes) do
    results = receive do
      {:chunk_result, value} -> results ++ [value]
    end
    await_results(num_results - 1, results, all_processes)
  end

  # This will calculate a list of rect_areas over the chunk_size
  # Given x1, x2, calculate a certain number of squares of width delta, then sum them up
  def eval_worker(parent_id, math_func, start_x, end_x, delta) do
    # When our worker is finished calculating the chunk's area, sends it back to the parent
    send(parent_id, {:chunk_result, eval_worker_helper(math_func, start_x, start_x + delta, end_x, delta, [])})
  end

  # BASE CASE
  # Sum up all of the calculated areas in this chunk
  def eval_worker_helper(_math_func, x1, _x2, end_x, _delta, areas_sofar) when x1 >= end_x do
    areas_sofar |> Enum.sum()
  end

  # Given x1 & x2, find the
  def eval_worker_helper(math_func, x1, x2, end_x, delta, areas_sofar) do
    eval_worker_helper( math_func, x1+delta, x2+delta, end_x, delta, areas_sofar ++ [calc_delta_square(x1, x2, math_func)] )
  end

  # Calculate the area of the square from x1 -> x2 using f(x1) as the height
  # We are using Left Riemann Sum
  defp calc_delta_square(x1, x2, math_func) do
    (x2 - x1) * (MathFunction.eval_func(math_func, x1) |> Enum.sum()) # width * height
  end

  def to_s(math_function, start_x, end_x, delta) do
    "Area under the curve of #{MathFunction.to_string(math_function)} from #{start_x} to #{end_x}: #{Integral.evaluate(math_function, start_x, end_x, delta)}"
  end

end

# =========================================================================

#x^2 + 3x + 4
func_so_far = MathFunction.add_term(4, 0, [])
func_so_far = MathFunction.add_term(3, 1, func_so_far)
func_so_far = MathFunction.add_term(1, 2, func_so_far)

#area from 1.0 to 2.0 with a box width of .001
IO.puts(Integral.to_s(func_so_far, 1.0, 2.0, 0.00001))

# Area under the curve of x^2 + 3x + 4 from 1.0 to 2.0: 10.941683499999966
