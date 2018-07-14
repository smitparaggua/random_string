defmodule ExRandomString.MixProject do
  use Mix.Project

  @github_url "https://github.com/smitparaggua/random_string"

  def project do
    [
      app: :ex_random_string,
      version: "1.0.1",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      name: "ExRandomString",
      source_url: @github_url,
      homepage_url: @github_url,
      docs: [main: "ExRandomString"],
      package: package(),
      description: "Library for generating random strings",
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["John Smith Paraggua"],
      licenses: ["MIT"],
      links: %{"GitHub" => @github_url}
    ]
  end
end
