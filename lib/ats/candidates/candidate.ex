defmodule Ats.Candidates.Candidate do
  @moduledoc """
  This module provides functions for managing candidates.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "candidates" do
    field :email, :string
    field :full_name, :string
    field :last_known_job, :string
    field :phone, :string
    has_many :applicants, Ats.Applicants.Applicant
    has_many :applicants_jobs, through: [:applicants, :job]

    timestamps()
  end

  @doc false
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:full_name, :email, :phone, :last_known_job])
    |> cast_assoc(:applicants, with: &Ats.Applicants.Applicant.changeset/2)
    |> validate_required([:full_name, :email, :phone, :last_known_job])
  end
end
