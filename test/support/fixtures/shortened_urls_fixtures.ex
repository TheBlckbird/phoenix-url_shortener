defmodule UrlShortener.ShortenedUrlsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UrlShortener.ShortenedUrls` context.
  """

  @doc """
  Generate a shortened_url.
  """
  def shortened_url_fixture(attrs \\ %{}) do
    {:ok, shortened_url} =
      attrs
      |> Enum.into(%{
        key: "some key",
        url: "some url"
      })
      |> UrlShortener.ShortenedUrls.create_shortened_url()

    shortened_url
  end
end
