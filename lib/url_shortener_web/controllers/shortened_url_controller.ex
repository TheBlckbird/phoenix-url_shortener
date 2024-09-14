defmodule UrlShortenerWeb.ShortenedUrlController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.ShortenedUrls
  alias UrlShortener.ShortenedUrls.ShortenedUrl

  def index(conn, _params) do
    shortened_urls = ShortenedUrls.list_shortened_urls()
    render(conn, :index, shortened_urls: shortened_urls)
  end

  def new(conn, _params) do
    changeset = ShortenedUrls.change_shortened_url(%ShortenedUrl{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"shortened_url" => shortened_url_params}) do
    case ShortenedUrls.create_shortened_url(shortened_url_params) do
      {:ok, shortened_url} ->
        conn
        |> put_flash(:info, "Shortened url created successfully.")
        |> redirect(to: ~p"/shortened_urls/#{shortened_url}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shortened_url = ShortenedUrls.get_shortened_url!(id)
    render(conn, :show, shortened_url: shortened_url)
  end

  def edit(conn, %{"id" => id}) do
    shortened_url = ShortenedUrls.get_shortened_url!(id)
    changeset = ShortenedUrls.change_shortened_url(shortened_url)
    render(conn, :edit, shortened_url: shortened_url, changeset: changeset)
  end

  def update(conn, %{"id" => id, "shortened_url" => shortened_url_params}) do
    shortened_url = ShortenedUrls.get_shortened_url!(id)

    case ShortenedUrls.update_shortened_url(shortened_url, shortened_url_params) do
      {:ok, shortened_url} ->
        conn
        |> put_flash(:info, "Shortened url updated successfully.")
        |> redirect(to: ~p"/shortened_urls/#{shortened_url}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, shortened_url: shortened_url, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    shortened_url = ShortenedUrls.get_shortened_url!(id)
    {:ok, _shortened_url} = ShortenedUrls.delete_shortened_url(shortened_url)

    conn
    |> put_flash(:info, "Shortened url deleted successfully.")
    |> redirect(to: ~p"/shortened_urls")
  end
end
