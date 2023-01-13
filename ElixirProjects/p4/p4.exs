defmodule Redactor do
  # transform words found in the redacted words file
  def redact(redacted_words_file_path, file_path) do
    dict_set =
      read_file_by_line(redacted_words_file_path)
      |> MapSet.new()

    read_file_by_line(file_path)
    |> redact_helper([], dict_set, "")
    |> Enum.join("\n")
  end

  # transform all of the words that are not in the redacted words file.
  def redact_inverse(safe_words_file_path, file_path) do
    dict_set =
      read_file_by_line(safe_words_file_path)
      |> MapSet.new()

    read_file_by_line(file_path)
    |> redact_helper([], dict_set, "INV")
    |> Enum.join("\n")
  end

  # ++ REDACT HELPER ++
  defp redact_helper([line | []], sofar, dict_set, mode) do
    sofar ++ [redact_line(line, dict_set, mode) |> Enum.join(" ")]
  end

  defp redact_helper([line | rest], sofar, dict_set, mode) do
    redact_helper(
      rest,
      sofar ++ [redact_line(line, dict_set, mode) |> Enum.join(" ")],
      dict_set,
      mode
    )
  end

  # ++ REDACT LINE ++
  # Start our line recursion
  defp redact_line(line, dict_set, mode) do
    String.split(line, " ")
    |> redact_line_helper([], dict_set, mode)
  end

  # ++ REDACT LINE HELPER
  # Catch the end of the line's recursion
  defp redact_line_helper([word | []], sofar, dict_set, mode) do
    sofar ++ [cleanse(word) |> get_redacted_word(dict_set, mode)]
  end

  # Recurse through the line, redacting each word if desired
  defp redact_line_helper([word | rest], sofar, dict_set, mode) do
    redact_line_helper(
      rest,
      sofar ++ [cleanse(word) |> get_redacted_word(dict_set, mode)],
      dict_set,
      mode
    )
  end

  # ++ GET REDACTED WORD ++
  defp get_redacted_word({dirty, clean}, dict_set, "INV") do
    redact_word_h(dirty, not MapSet.member?(dict_set, clean))
  end

  defp get_redacted_word({dirty, clean}, dict_set, _) do
    redact_word_h(dirty, MapSet.member?(dict_set, clean))
  end

  defp redact_word_h(dirty, true) do
    String.replace(dirty, ~r/./, "x")
  end

  defp redact_word_h(dirty, false) do
    dirty
  end

  # ----------------------------------
  # ----------------------------------
  defp read_file_by_line(file_path) do
    File.read!(file_path) |> String.replace("\r", "") |> String.split("\n")
  end

  # ----------------------------------
  # ----------------------------------

  # ***************
  #   CLEANSE
  # ***************
  # Remove punctuation
  # And make it lowercase
  # returns tuple
  def cleanse(word) do
    # lowercase all letters
    clean =
      String.downcase(word)
      # remove any punc
      |> String.replace(~r/[^A-Z^a-z^0-9]/, "")

    {word, clean}
  end
end

# CODE TO EXECUTE ON START
dict_path = "1000words.txt"
text_path = "sqrt110.txt"

Redactor.redact(dict_path, text_path) |> IO.puts()
IO.puts("\n")
Redactor.redact_inverse(dict_path, text_path) |> IO.puts()
