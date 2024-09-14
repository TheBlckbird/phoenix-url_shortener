defmodule UrlShortener.ShortenedUrlsTest do
  use UrlShortener.DataCase

  alias UrlShortener.ShortenedUrls

  describe "shortened_urls" do
    alias UrlShortener.ShortenedUrls.ShortenedUrl

    import UrlShortener.ShortenedUrlsFixtures

    @invalid_attrs %{key: nil, url: nil}

    test "list_shortened_urls/0 returns all shortened_urls" do
      shortened_url = shortened_url_fixture()
      assert ShortenedUrls.list_shortened_urls() == [shortened_url]
    end

    test "get_shortened_url!/1 returns the shortened_url with given id" do
      shortened_url = shortened_url_fixture()
      assert ShortenedUrls.get_shortened_url!(shortened_url.id) == shortened_url
    end

    test "create_shortened_url/1 with valid data creates a shortened_url" do
      valid_attrs = %{key: "some key", url: "some url"}

      assert {:ok, %ShortenedUrl{} = shortened_url} = ShortenedUrls.create_shortened_url(valid_attrs)
      assert shortened_url.key == "some key"
      assert shortened_url.url == "some url"
    end

    test "create_shortened_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ShortenedUrls.create_shortened_url(@invalid_attrs)
    end

    test "update_shortened_url/2 with valid data updates the shortened_url" do
      shortened_url = shortened_url_fixture()
      update_attrs = %{key: "some updated key", url: "some updated url"}

      assert {:ok, %ShortenedUrl{} = shortened_url} = ShortenedUrls.update_shortened_url(shortened_url, update_attrs)
      assert shortened_url.key == "some updated key"
      assert shortened_url.url == "some updated url"
    end

    test "update_shortened_url/2 with invalid data returns error changeset" do
      shortened_url = shortened_url_fixture()
      assert {:error, %Ecto.Changeset{}} = ShortenedUrls.update_shortened_url(shortened_url, @invalid_attrs)
      assert shortened_url == ShortenedUrls.get_shortened_url!(shortened_url.id)
    end

    test "delete_shortened_url/1 deletes the shortened_url" do
      shortened_url = shortened_url_fixture()
      assert {:ok, %ShortenedUrl{}} = ShortenedUrls.delete_shortened_url(shortened_url)
      assert_raise Ecto.NoResultsError, fn -> ShortenedUrls.get_shortened_url!(shortened_url.id) end
    end

    test "change_shortened_url/1 returns a shortened_url changeset" do
      shortened_url = shortened_url_fixture()
      assert %Ecto.Changeset{} = ShortenedUrls.change_shortened_url(shortened_url)
    end
  end
end
