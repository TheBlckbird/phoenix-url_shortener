defmodule UrlShortener.ShortenedUrls do
  @moduledoc """
  The ShortenedUrls context.
  """

  import Ecto.Query, warn: false
  alias UrlShortener.Repo

  alias UrlShortener.ShortenedUrls.ShortenedUrl

  @doc """
  Returns the list of shortened_urls.

  ## Examples

      iex> list_shortened_urls()
      [%ShortenedUrl{}, ...]

  """
  def list_shortened_urls do
    Repo.all(ShortenedUrl)
  end

  @doc """
  Gets a single shortened_url.

  Raises `Ecto.NoResultsError` if the Shortened url does not exist.

  ## Examples

      iex> get_shortened_url!(123)
      %ShortenedUrl{}

      iex> get_shortened_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shortened_url!(id), do: Repo.get!(ShortenedUrl, id)

  @doc """
  Creates a shortened_url.

  ## Examples

      iex> create_shortened_url(%{field: value})
      {:ok, %ShortenedUrl{}}

      iex> create_shortened_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shortened_url(attrs \\ %{}) do
    %ShortenedUrl{}
    |> ShortenedUrl.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shortened_url.

  ## Examples

      iex> update_shortened_url(shortened_url, %{field: new_value})
      {:ok, %ShortenedUrl{}}

      iex> update_shortened_url(shortened_url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shortened_url(%ShortenedUrl{} = shortened_url, attrs) do
    shortened_url
    |> ShortenedUrl.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shortened_url.

  ## Examples

      iex> delete_shortened_url(shortened_url)
      {:ok, %ShortenedUrl{}}

      iex> delete_shortened_url(shortened_url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shortened_url(%ShortenedUrl{} = shortened_url) do
    Repo.delete(shortened_url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shortened_url changes.

  ## Examples

      iex> change_shortened_url(shortened_url)
      %Ecto.Changeset{data: %ShortenedUrl{}}

  """
  def change_shortened_url(%ShortenedUrl{} = shortened_url, attrs \\ %{}) do
    ShortenedUrl.changeset(shortened_url, attrs)
  end
end
