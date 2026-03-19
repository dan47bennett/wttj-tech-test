defmodule Ats.Repo.Migrations.AddRemoteToJobs do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      add :work_mode, :string, default: "onsite"
    end
  end
end
