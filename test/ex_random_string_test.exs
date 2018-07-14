defmodule ExRandomStringTest do
  use ExUnit.Case
  doctest ExRandomString

  test "by default returns a string 32 characters long" do
    assert String.length(ExRandomString.generate()) == 32
  end

  test "by default returns alpha-numeric" do
    assert String.match?(ExRandomString.generate(), ~r/^[0-9a-z]*$/i)
  end

  test "changes every call" do
    first = ExRandomString.generate()
    second = ExRandomString.generate()
    third = ExRandomString.generate()
    refute first == second
    refute first == third
    refute second == third
  end

  test "when an integer is passed, return string of that length" do
    string = ExRandomString.generate(21)
    assert String.length(string) == 21
  end

  test "allows setting length via keyword options" do
    string = ExRandomString.generate(length: 21)
    assert String.length(string) == 21
  end

  test "empty options act the same way as the default (no params)" do
    string = ExRandomString.generate([])
    assert String.length(string) == 32
    assert String.match?(string, ~r/^[0-9a-z]*$/i)
  end

  test "limits to alphabetic characters through charset: :alphabetic" do
    string1 = ExRandomString.generate(charset: :alphabetic)
    string2 = ExRandomString.generate(charset: :alphabetic)
    string3= ExRandomString.generate(charset: :alphabetic)
    assert String.match?(string1, ~r/^[a-z]+$/i)
    assert String.match?(string2, ~r/^[a-z]+$/i)
    assert String.match?(string3, ~r/^[a-z]+$/i)
  end

  test "limits to numeric characters through charset: :numeric" do
    string1 = ExRandomString.generate(charset: :numeric)
    string2 = ExRandomString.generate(charset: :numeric)
    string3= ExRandomString.generate(charset: :numeric)
    assert String.match?(string1, ~r/^[0-9]+$/)
    assert String.match?(string2, ~r/^[0-9]+$/)
    assert String.match?(string3, ~r/^[0-9]+$/)
  end

  test "limits to hex characters through charset: :hex" do
    string1 = ExRandomString.generate(charset: :hex)
    string2 = ExRandomString.generate(charset: :hex)
    string3= ExRandomString.generate(charset: :hex)
    assert String.match?(string1, ~r/^[0-9a-f]+$/)
    assert String.match?(string2, ~r/^[0-9a-f]+$/)
    assert String.match?(string3, ~r/^[0-9a-f]+$/)
  end

  test "limits to custom set of characters through charset: [<char>, <char>, ...]" do
    string1 = ExRandomString.generate(charset: "a")
    string2 = ExRandomString.generate(charset: "abc")
    string3= ExRandomString.generate(charset: "123")
    assert String.match?(string1, ~r/^[a]+$/)
    assert String.match?(string2, ~r/^[a-c]+$/)
    assert String.match?(string3, ~r/^[1-3]+$/)
  end

  test "forces lowercase via case: :lower" do
    string = ExRandomString.generate(case: :lower)
    assert String.match?(string, ~r/^[a-z0-9]+$/)
  end

  test "forces uppercase via case: :upper" do
    string = ExRandomString.generate(case: :upper)
    assert String.match?(string, ~r/^[A-Z0-9]+$/)
  end

  test "forces mixed case via case: :mix" do
    string = ExRandomString.generate(case: :mix)
    assert String.match?(string, ~r/^[a-z0-9]+$/i)
    assert String.match?(string, ~r/[a-z]/)
    assert String.match?(string, ~r/[A-Z]/)
  end
end
