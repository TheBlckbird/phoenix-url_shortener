defmodule UrlShortenerWeb.ShortenedUrlController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Repo
  alias UrlShortener.ShortenedUrls
  alias UrlShortener.ShortenedUrls.ShortenedUrl

  def new(conn, _params) do
    changeset = ShortenedUrls.change_shortened_url(%ShortenedUrl{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"shortened_url" => shortened_url_params}) do
    case ShortenedUrls.create_shortened_url(shortened_url_params) do
      {:ok, shortened_url} ->
        conn
        |> put_flash(:info, "Shortened url created successfully.")
        |> redirect(to: ~p"/created/#{shortened_url.key}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def created(conn, %{"key" => key}) do
    shortened_url = Repo.get_by!(ShortenedUrl, key: key)
    render(conn, :created, shortened_url: shortened_url)
  end

  def show(conn, %{"key" => key}) do
    shortened_url = Repo.get_by!(ShortenedUrl, key: key)
    redirect(conn, external: shortened_url.url)
  end
end
