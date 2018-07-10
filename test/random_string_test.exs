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
end
