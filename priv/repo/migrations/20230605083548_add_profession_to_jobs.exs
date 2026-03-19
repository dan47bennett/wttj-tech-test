defmodule Ats.Repo.Migrations.AddProfessionToJobs do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      add :profession_id, references(:professions, on_delete: :nothing)
    end
  end
end
