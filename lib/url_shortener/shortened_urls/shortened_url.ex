defmodule UrlShortener.ShortenedUrls.ShortenedUrl do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  # import String

  schema "shortened_urls" do
    field :key, :string
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(shortened_url, attrs) do
    shortened_url
    |> cast(attrs, [:url])
    |> validate_required([:url])
    |> validate_format(:url, ~r/http(s)?:\/\/.*/)
    # |> put_change(:url, fn changeset ->
    #   original_url = get_field(changeset, :url)

    #   modified_url = original_url |> to_string()

    #   if(
    #     not (original_url |> starts_with?("http://") or original_url |> starts_with?("https://"))
    #   ) do
    #     "http://" <> modified_url
    #   end

    #   modified_url
    # end)
    |> put_change(:key, generate_unique_key())
  end

  defp generate_unique_key do
    generated_key = fn -> :crypto.strong_rand_bytes(6) |> Base.url_encode64(padding: false) end
    generate_unique_value(UrlShortener.Repo, __MODULE__, :key, generated_key)
  end

  defp generate_unique_value(repo, schema, field, generate_value_fn) do
    value = generate_value_fn.()

    case repo.one(from e in schema, where: field(e, ^field) == ^value, select: 1, limit: 1) do
      nil -> value
      _ -> generate_unique_value(repo, schema, field, generate_value_fn)
    end
  end
end
