defmodule UrlShortenerWeb.ShortenedUrlHTML do
  use UrlShortenerWeb, :html

  embed_templates "shortened_url_html/*"

  @doc """
  Renders a shortened_url form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def shortened_url_form(assigns)
end
