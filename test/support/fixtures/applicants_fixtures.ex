defmodule Ats.ApplicantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ats.Applicants` context.
  """

  @doc """
  Generate a applicant.
  """
  def applicant_fixture(attrs \\ %{}) do
    {:ok, applicant} =
      attrs
      |> Enum.into(%{
        application_date: ~D[2023-06-03],
        salary_expectation: 42,
        status: "some status"
      })
      |> Ats.Applicants.create_applicant()

    applicant
  end
end
