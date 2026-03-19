defmodule Ats.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :string
      add :description, :text
      add :office, :string
      add :contract_type, :string
      add :status, :string

      timestamps()
    end
  end
end
