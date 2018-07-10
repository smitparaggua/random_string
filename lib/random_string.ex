defmodule RandomString do
  @numeric ~w(1 2 3 4 6 7 8 9 0)
  @alpha ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  @alphanumeric @alpha ++ @numeric

  @default_length 32

  def generate do
    generate(@default_length)
  end

  def generate(length) when is_integer(length) do
    characters = @alphanumeric
    character_count = Enum.count(characters)
    Stream.repeatedly(fn -> random_character(characters, character_count) end)
    |> Stream.take(length)
    |> Enum.join("")
  end

  defp random_character(characters, character_count) do
    random_index = :rand.uniform(character_count) - 1
    Enum.at(characters, random_index)
  end
end
