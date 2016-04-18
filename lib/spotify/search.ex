defmodule Spotify.Search do
  import Spotify.Client
  alias Spotify.Pagination

  defstruct [:href, :results, :pagination]

  @endpoint "search"
  @root_keys %{
    album: "albums",
    artist: "artists"
  }

  def new(query, type, limit \\ 20, offset \\ 0) do
    root_key = @root_keys[String.to_atom(type)]
    get!(@endpoint, [], params: %{
      query: query,
      type: type,
      limit: limit,
      offset: offset
    })
    |> parse_response
    |> Poison.decode!
    |> normalize(root_key)
  end

  @root_keys %{
    album: "albums",
    artist: "artists"
  }

  defp normalize(response, root_key) do
    {results, pagination} = Pagination.new(response[root_key])
    %__MODULE__{
      results: results,
      pagination: pagination,
      href: results["href"]
    }
  end
end