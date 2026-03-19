defmodule Ats.Repo.Migrations.CreateApplicants do
  use Ecto.Migration

  def change do
    create table(:applicants) do
      add :application_date, :date
      add :status, :string
      add :salary_expectation, :integer
      add :candidate_id, references(:candidates, on_delete: :nothing)
      add :job_id, references(:jobs, on_delete: :nothing)

      timestamps()
    end

    create index(:applicants, [:candidate_id])
    create index(:applicants, [:job_id])
  end
end
