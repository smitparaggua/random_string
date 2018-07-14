# ExRandomString

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

## Documentation

Documentation is available at:
[HexDocs](https://hexdocs.pm/ex_random_string/ExRandomString.html)
