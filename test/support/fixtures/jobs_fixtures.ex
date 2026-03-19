defmodule Ats.JobsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ats.Jobs` context.
  """

  @doc """
  Generate a job.
  """
  def job_fixture(attrs \\ %{}) do
    {:ok, job} =
      attrs
      |> Enum.into(%{
        contract_type: "FULL_TIME",
        description: "Elixir dev backend",
        office: "Paris",
        status: "draft",
        title: "Dev Backend",
        work_mode: "onsite",
        profession: nil
      })
      |> Ats.Jobs.create_job()

    job
  end
end
