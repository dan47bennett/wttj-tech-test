defmodule Ats.Repo.Migrations.CreateProfessions do
  use Ecto.Migration

  def change do
    create table(:professions) do
      add :name, :string
      add :category_name, :string

      timestamps()
    end
  end
end
