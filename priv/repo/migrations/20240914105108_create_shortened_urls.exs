defmodule UrlShortener.Repo.Migrations.CreateShortenedUrls do
  use Ecto.Migration

  def change do
    create table(:shortened_urls) do
      add :key, :string, primary_key: true
      add :url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
