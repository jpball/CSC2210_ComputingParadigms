# Create an Exlir program that will return random words
#   from a dictionary file.

# Create a process that sits and waits for requests
#   for a specific number of random words.


#The request may look like this
# {self(), {:random_words, 5}}

# The process will preload all the words from the file
# and then pull the requested number of them randomly.

# From the main process send the request and display the returned words.

defmodule WR do
  def main() do
    dict_path = "bigDictionary.txt"
    dict_map = read_path(dict_path) |> MapSet.new()

    reader_pid = spawn(WR, :reader, [dict_map])

    num_words = 5
    send(reader_pid, {self(), {:random_words, num_words}})

    receive do
      results -> IO.inspect(results)
    end

    send(reader_pid, {:kill})
    :main_done
  end

  def reader(dict_map) do
    receive do
      {pid, {:random_words, num_words}} -> send(pid, get_rand_words(num_words, [], dict_map))
      {:kill} -> Process.exit(self(), "End")
    end
    reader(dict_map)
  end

  defp get_rand_words(0, results, _dict_map) do
    results
  end

  defp get_rand_words(num_words, results, dict_map) do
    get_rand_words(num_words - 1, results ++ [Enum.random(dict_map)], dict_map)
  end

  defp read_path(path) do
    File.read!(path) |> String.replace("\r", "") |> String.split("\n")
  end


end

WR.main()
