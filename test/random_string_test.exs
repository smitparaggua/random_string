defmodule RandomStringTest do
  use ExUnit.Case
  doctest RandomString

  test "by default returns a string 32 characters long" do
    assert String.length(RandomString.generate()) == 32
  end

  test "by default returns alpha-numeric" do
    assert String.match?(RandomString.generate(), ~r/^[0-9a-z]*$/i)
  end

  test "changes every call" do
    first = RandomString.generate()
    second = RandomString.generate()
    third = RandomString.generate()
    refute first == second
    refute first == third
    refute second == third
  end

  test "when an integer is passed, return string of that length" do
    string = RandomString.generate(21)
    assert String.length(string) == 21
  end

  test "allows setting length via keyword options" do
    string = RandomString.generate(length: 21)
    assert String.length(string) == 21
  end

  test "empty options act the same way as the default (no params)" do
    string = RandomString.generate([])
    assert String.length(string) == 32
    assert String.match?(string, ~r/^[0-9a-z]*$/i)
  end

  test "limits to alphabetic characters through charset: :alphabetic" do
    string1 = RandomString.generate(charset: :alphabetic)
    string2 = RandomString.generate(charset: :alphabetic)
    string3= RandomString.generate(charset: :alphabetic)
    assert String.match?(string1, ~r/^[a-z]+$/i)
    assert String.match?(string2, ~r/^[a-z]+$/i)
    assert String.match?(string3, ~r/^[a-z]+$/i)
  end

  test "limits to numeric characters through charset: :numeric" do
    string1 = RandomString.generate(charset: :numeric)
    string2 = RandomString.generate(charset: :numeric)
    string3= RandomString.generate(charset: :numeric)
    assert String.match?(string1, ~r/^[0-9]+$/)
    assert String.match?(string2, ~r/^[0-9]+$/)
    assert String.match?(string3, ~r/^[0-9]+$/)
  end

  test "limits to hex characters through charset: :hex" do
    string1 = RandomString.generate(charset: :hex)
    string2 = RandomString.generate(charset: :hex)
    string3= RandomString.generate(charset: :hex)
    assert String.match?(string1, ~r/^[0-9a-f]+$/)
    assert String.match?(string2, ~r/^[0-9a-f]+$/)
    assert String.match?(string3, ~r/^[0-9a-f]+$/)
  end

  test "limits to custom set of characters through charset: [<char>, <char>, ...]" do
    string1 = RandomString.generate(charset: ["a"])
    string2 = RandomString.generate(charset: ~w(a b c))
    string3= RandomString.generate(charset: ~w(1 2 3))
    assert String.match?(string1, ~r/^[a]+$/)
    assert String.match?(string2, ~r/^[a-c]+$/)
    assert String.match?(string3, ~r/^[1-3]+$/)
  end
end
