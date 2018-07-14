defmodule ExRandomString do
  @moduledoc """
  Library for generating random strings. Based on NodeJS library
  [randomstring](https://www.npmjs.com/package/randomstring).

  ## Installation

  The package can be installed by adding `ex_random_string` to your list of
  dependencies in `mix.exs`:

  ```elixir
  def deps do
    [
      {:ex_random_string, "~> 1.0.1"}
    ]
  end
  ```

  ## Usage

  ```elixir
  ExRandomString.generate()
  # "XwPp9xazJ0ku5CZnlmgAx2Dld8SHkAeT"

  ExRandomString.generate(7);
  # "xqm5wXX"

  ExRandomString.generate(length: 12, charset: :alphabetic)
  # "AqoTIzKurxJi"

  ExRandomString.generate(charset: ~w(a b c));
  # "accbaabbbbcccbccccaacacbbcbbcbbc"
  ```
  """

  @numeric ~w(1 2 3 4 6 7 8 9 0)
  @alpha ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  @hex @numeric ++ ~w(a b c d e f)
  @alphanumeric @alpha ++ @numeric
  @default_options [charset: :alphanumeric, length: 32]

  @doc """
  Generates a random string that is 32 characters long and alphanumeric.
  """
  def generate do
    generate(@default_options[:length])
  end

  @doc """
  When provided an integer, it generates a random string with the provided
  integer as length. String returned will be alphanumeric.

  When provided a Keyword list, it generates a random string with properties
  based on the provided options.

  ## Options

  Listed below are the supported options. Each of the options are optional.

  * `length` -- the length of the random string. (default: 32)
  * `charset` -- define the character set for the string. (default: `:alphanumeric`)
    * `:alphanumeric` -- [0-9a-zA-Z]
    * `:alphabetic` -- [a-zA-Z]
    * `:numeric` -- [0-9]
    * `:hex` -- [0-9a-f]
    * any string -- will generate based on the string's set of characters
  * `case` -- define whether the output should be lowercase / uppercase only.
    (default: `nil`)
    * `:lower` -- forces all characters to use lower case
    * `:upper` -- forces all characters to use upper case
    * `:mix` -- randomizes the case of each character

  ## Examples

  ```
  ExRandomString.generate(7)
  # "xqm5wXX"

  ExRandomString.generate(length: 12, charset: :alphabetic)
  # "AqoTIzKurxJi"

  ExRandomString.generate(charset: "ABC", case: :lower)
  # "abaccabaacbaabcccabacbacccacbbbb"
  ```
  """
  def generate(options)

  def generate(length) when is_integer(length) do
    generate(length: length)
  end

  def generate(options) do
    options = with_default_options(options)
    characters = characters_for_charset(options[:charset])
    character_count = Enum.count(characters)
    Stream.repeatedly(fn -> random_character(characters, character_count) end)
    |> Stream.map(case_modifier(options))
    |> Stream.take(options[:length])
    |> Enum.join("")
  end

  defp characters_for_charset(charset) do
    case charset do
      :alphanumeric -> @alphanumeric
      :alphabetic -> @alpha
      :numeric -> @numeric
      :hex -> @hex
      characters -> String.graphemes(characters)
    end
  end

  defp random_character(characters, character_count) do
    random_index = :rand.uniform(character_count) - 1
    Enum.at(characters, random_index)
  end

  defp case_modifier(options) do
    case options[:case] do
      :upper -> &String.upcase/1
      :lower -> &String.downcase/1
      :mix -> &randomize_case/1
      _ -> case_modifier_for_charset(options[:charset])
    end
  end

  defp case_modifier_for_charset(charset) do
    identity = &(&1)
    case charset do
      :alphanumeric -> &randomize_case/1
      :alphabetic -> &randomize_case/1
      :numeric -> identity
      :hex -> identity
      _ -> identity
    end
  end

  defp randomize_case(character) do
    case :rand.uniform(2) do
      1 -> String.downcase(character)
      2 -> String.upcase(character)
    end
  end

  defp with_default_options(options) do
    Keyword.merge(@default_options, options)
  end
end
