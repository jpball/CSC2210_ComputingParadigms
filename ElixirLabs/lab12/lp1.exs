# 1) Write a program with a single module that includes a
#   family of functions that will return a string describing
#   the state of water at a particular temperature ("ice", "liquid", or "steam").
#   The family of functions will take the temperature and the scale being used (either F or C).

defmodule WaterState do
  def get_state(temperature, "F") when temperature <= 32 do
    "ice"
  end

  def get_state(temperature, "F") when temperature >= 212 do
    "steam"
  end

  def get_state(_temperature, "F") do
    "liquid"
  end

  def get_state(temperature, "C") when temperature <= 0 do
    "ice"
  end

  def get_state(temperature, "C") when temperature >= 100 do
    "steam"
  end

  def get_state(_temperature, "C") do
    "liquid"
  end
end

prog = fn(_a) ->
  temp = Enum.random(-50..250)
  opts = ["F", "C"]
  scale = Enum.random(opts)
  state = WaterState.get_state(temp, scale)
  IO.puts("#{temp}^#{scale} is #{state}")
end

(0..10) |> Enum.each(prog)
