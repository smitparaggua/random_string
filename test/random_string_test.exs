defmodule RandomStringTest do
  use ExUnit.Case
  doctest RandomString

  test "greets the world" do
    assert RandomString.hello() == :world
  end
end
