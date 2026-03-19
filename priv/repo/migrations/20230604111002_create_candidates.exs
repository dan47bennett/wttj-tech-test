defmodule Ats.Repo.Migrations.CreateCandidates do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :full_name, :string
      add :email, :text
      add :phone, :string
      add :last_known_job, :string

      timestamps()
    end
  end
end
