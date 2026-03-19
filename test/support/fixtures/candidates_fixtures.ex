defmodule Ats.CandidatesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ats.Candidates` context.
  """

  @doc """
  Generate a candidate.
  """
  def candidate_fixture(attrs \\ %{}) do
    {:ok, candidate} =
      attrs
      |> Enum.into(%{
        email: "some email",
        full_name: "some full_name",
        last_known_job: "some last_known_job",
        phone: "some phone"
      })
      |> Ats.Candidates.create_candidate()

    candidate
  end
end
