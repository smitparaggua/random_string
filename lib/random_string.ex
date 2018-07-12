defmodule RandomString do
  @numeric ~w(1 2 3 4 6 7 8 9 0)
  @alpha ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  @hex @numeric ++ ~w(a b c d e f)
  @alphanumeric @alpha ++ @numeric

  @default_options [charset: :alphanumeric, length: 32]

  def generate do
    generate(@default_options[:length])
  end

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
      characters -> characters
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
