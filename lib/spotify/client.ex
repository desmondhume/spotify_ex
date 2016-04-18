defmodule Spotify.Client do
  use HTTPoison.Base

  def process_url(endpoint) do
    if String.starts_with?(endpoint, "http") do
      endpoint
    else
      "https://api.spotify.com/v1/" <> endpoint
    end
  end

  def parse_response(%HTTPoison.Response{status_code: 200, body: ""}), do: nil
  def parse_response(%HTTPoison.Response{status_code: 200, body: body}), do: body
  def parse_response(%HTTPoison.Response{status_code: status_code, body: ""}), do: { status_code, nil }
  def parse_response(%HTTPoison.Response{status_code: status_code, body: body }), do: { status_code, body }
end