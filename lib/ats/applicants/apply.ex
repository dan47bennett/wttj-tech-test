defmodule Ats.Applicants.Apply do
  @moduledoc """
  This module provides functions for managing applications.
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :email, :string
    field :full_name, :string
    field :last_known_job, :string
    field :phone, :string
    field :salary_expectation, :integer
    field :job_id, :integer
  end

  @doc """
  Builds a changeset for validating application form data.

  Casts and validates all required fields for a new application:
  full_name, email, phone, last_known_job, salary_expectation, and job_id.

  ## Examples

      iex> changeset(%Apply{}, %{full_name: "John", email: "john@example.com", phone: "123456", last_known_job: "Developer", salary_expectation: 50000, job_id: 1})
      %Ecto.Changeset{valid?: true}

      iex> changeset(%Apply{}, %{full_name: "John"})
      %Ecto.Changeset{valid?: false}

  """
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
  def changeset(apply, attrs) do
    apply
    |> cast(attrs, [:full_name, :email, :phone, :last_known_job, :salary_expectation, :job_id])
    |> validate_required([
      :full_name,
      :email,
      :phone,
      :last_known_job,
      :salary_expectation,
      :job_id
    ])
  end

  @doc """
  Converts a valid application changeset to a candidate changeset.

  Extracts the relevant fields from the application data (full_name, email, phone, last_known_job)
  and creates a changeset for creating a new candidate.

  ## Examples

      iex> changeset = changeset(%Apply{}, %{full_name: "John", email: "john@example.com", phone: "123456", last_known_job: "Developer", salary_expectation: 50000, job_id: 1})
      iex> to_candidate(changeset)
      %Ecto.Changeset{data: %Ats.Candidates.Candidate{}}

  """
  @spec to_candidate(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def to_candidate(%Ecto.Changeset{changes: changes}) do
    Ats.Candidates.Candidate.changeset(
      %Ats.Candidates.Candidate{},
      %{
        full_name: changes.full_name,
        email: changes.email,
        phone: changes.phone,
        last_known_job: changes.last_known_job
      }
    )
  end

  @doc """
  Converts a valid application changeset to an applicant changeset.

  Extracts the application date (defaults to today), salary expectation, and job_id
  from the changeset and creates a changeset for creating a new applicant with
  an initial status of "new".

  ## Examples

      iex> changeset = changeset(%Apply{}, %{full_name: "John", email: "john@example.com", phone: "123456", last_known_job: "Developer", salary_expectation: 50000, job_id: 1})
      iex> to_applicant(changeset)
      %Ecto.Changeset{data: %Ats.Applicants.Applicant{}}

  """
  @spec to_applicant(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def to_applicant(%Ecto.Changeset{changes: changes}) do
    Ats.Applicants.Applicant.changeset(%Ats.Applicants.Applicant{}, %{
      application_date: Date.utc_today(),
      status: "new",
      salary_expectation: changes.salary_expectation,
      job_id: changes.job_id
    })
  end
end
