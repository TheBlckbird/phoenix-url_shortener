defmodule UrlShortenerWeb.ShortenedUrlControllerTest do
  use UrlShortenerWeb.ConnCase

  import UrlShortener.ShortenedUrlsFixtures

  @create_attrs %{key: "some key", url: "some url"}
  @update_attrs %{key: "some updated key", url: "some updated url"}
  @invalid_attrs %{key: nil, url: nil}

  describe "index" do
    test "lists all shortened_urls", %{conn: conn} do
      conn = get(conn, ~p"/shortened_urls")
      assert html_response(conn, 200) =~ "Listing Shortened urls"
    end
  end

  describe "new shortened_url" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/shortened_urls/new")
      assert html_response(conn, 200) =~ "New Shortened url"
    end
  end

  describe "create shortened_url" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/shortened_urls", shortened_url: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/shortened_urls/#{id}"

      conn = get(conn, ~p"/shortened_urls/#{id}")
      assert html_response(conn, 200) =~ "Shortened url #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/shortened_urls", shortened_url: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Shortened url"
    end
  end

  describe "edit shortened_url" do
    setup [:create_shortened_url]

    test "renders form for editing chosen shortened_url", %{conn: conn, shortened_url: shortened_url} do
      conn = get(conn, ~p"/shortened_urls/#{shortened_url}/edit")
      assert html_response(conn, 200) =~ "Edit Shortened url"
    end
  end

  describe "update shortened_url" do
    setup [:create_shortened_url]

    test "redirects when data is valid", %{conn: conn, shortened_url: shortened_url} do
      conn = put(conn, ~p"/shortened_urls/#{shortened_url}", shortened_url: @update_attrs)
      assert redirected_to(conn) == ~p"/shortened_urls/#{shortened_url}"

      conn = get(conn, ~p"/shortened_urls/#{shortened_url}")
      assert html_response(conn, 200) =~ "some updated key"
    end

    test "renders errors when data is invalid", %{conn: conn, shortened_url: shortened_url} do
      conn = put(conn, ~p"/shortened_urls/#{shortened_url}", shortened_url: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Shortened url"
    end
  end

  describe "delete shortened_url" do
    setup [:create_shortened_url]

    test "deletes chosen shortened_url", %{conn: conn, shortened_url: shortened_url} do
      conn = delete(conn, ~p"/shortened_urls/#{shortened_url}")
      assert redirected_to(conn) == ~p"/shortened_urls"

      assert_error_sent 404, fn ->
        get(conn, ~p"/shortened_urls/#{shortened_url}")
      end
    end
  end

  defp create_shortened_url(_) do
    shortened_url = shortened_url_fixture()
    %{shortened_url: shortened_url}
  end
end
