defmodule Ats.Jobs.Job do
  @moduledoc """
  This module provides functions for managing jobs.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :title, :string
    field :description, :string

    field :contract_type, Ecto.Enum,
      values: [:FULL_TIME, :PART_TIME, :TEMPORARY, :FREELANCE, :INTERNSHIP, :APPRENTICESHIP, :VIE]

    field :office, :string

    field :status, Ecto.Enum,
      values: [:draft, :published, :filled, :archived, :cancelled],
      default: :draft

    field :work_mode, Ecto.Enum, values: [:onsite, :remote, :hybrid], default: :onsite

    belongs_to :profession, Ats.Professions.Profession
    has_many :applicants, Ats.Applicants.Applicant

    timestamps()
  end

  @doc false
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
  def changeset(job, attrs) do
    job
    |> cast(attrs, [
      :title,
      :description,
      :office,
      :contract_type,
      :status,
      :work_mode
    ])
    |> validate_required([:title, :office, :contract_type])
  end
end
