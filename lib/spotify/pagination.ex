defmodule Spotify.Pagination do
  defstruct [
    :limit,
    :next,
    :offset,
    :previous,
    :total,
  ]

  def new(payload) do
    {pagination_params, collection} = Map.split(payload, ["limit", "next", "offset", "previous", "total"])
    {collection, %__MODULE__{
      limit:    pagination_params["limit"],
      next:     pagination_params["next"],
      offset:   pagination_params["offset"],
      previous: pagination_params["previous"],
      total:    pagination_params["total"]
    }}
  end
end