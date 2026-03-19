defmodule Ats.Jobs do
  @moduledoc """
  The Jobs context.
  """

  import Ecto.Query, warn: false
  alias Ats.Repo

  alias Ats.Jobs.Job
  alias Ats.Professions.Profession

  @contract_types %{
    FULL_TIME: "Full-Time",
    PART_TIME: "Part-Time",
    TEMPORARY: "Temporary",
    FREELANCE: "Freelance",
    INTERNSHIP: "Internship"
  }

  @doc """
  Returns a job contract type.

  ## Examples

      iex> contract_type(%Job{contract_type: "FULL_TIME"})
      "Full-Time"

  """
  @spec contract_type(%Job{}) :: binary() | nil
  def contract_type(job) do
    @contract_types[job.contract_type]
  end

  @doc """
  Returns a job profession name.

  ## Examples

      iex> profession_name(%Job{profession: %Profession{name: "Software Engineer"}})
      "Software Engineer"
  """
  @spec profession_name(%Job{}) :: binary()
  def profession_name(%Job{profession: %Profession{name: profession_name}}) do
    profession_name
  end

  def profession_name(_job), do: ""

  @doc """
  filters jobs by query params

  ## Examples

      iex> filterJobs()
      [%Job{}, ...]

  """
  @spec filterJobs([%Job{}], map()) :: [%Job{}]
  def filterJobs(jobs, params) do
    maybeSearch = params["search"]

    search =
      if maybeSearch == nil do
        []
      else
        String.split(maybeSearch)
      end

    if length(search)==0 do
      jobs
    else
      filteredJobs = Enum.filter(jobs, fn %{title: title} ->
        Enum.any?(search, fn s -> String.contains? String.downcase(title), String.downcase(s) end)
      end)

      filteredJobs
    end
  end

  @doc """
  Returns the list of jobs.

  ## Examples

      iex> list_jobs()
      [%Job{}, ...]

  """
  @spec list_jobs(map()) :: [%Job{}]
  def list_jobs(params) do
    allJobs = Repo.all(Job)
    filteredJobs = filterJobs(allJobs, params)

    filteredJobs |> Repo.preload(:profession)
  end

  @doc """
  Gets a single job.

  Raises `Ecto.NoResultsError` if the Job does not exist.

  ## Examples

      iex> get_job!(123)
      %Job{}

      iex> get_job!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_job!(integer() | binary()) :: %Job{}
  def get_job!(id), do: Repo.get!(Job, id) |> Repo.preload(applicants: [:candidate])

  @doc """
  Creates a job.

  ## Examples

      iex> create_job(%{field: value})
      {:ok, %Job{}}

      iex> create_job(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_job(map()) :: {:ok, %Job{}} | {:error, Ecto.Changeset.t()}
  def create_job(attrs \\ %{}) do
    %Job{}
    |> Job.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a job.

  ## Examples

      iex> update_job(job, %{field: new_value})
      {:ok, %Job{}}

      iex> update_job(job, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_job(%Job{}, map()) :: {:ok, %Job{}} | {:error, Ecto.Changeset.t()}
  def update_job(%Job{} = job, attrs) do
    job
    |> Job.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a job.

  ## Examples

      iex> delete_job(job)
      {:ok, %Job{}}

      iex> delete_job(job)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_job(%Job{}) :: {:ok, %Job{}} | {:error, Ecto.Changeset.t()}
  def delete_job(%Job{} = job) do
    Repo.delete(job)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking job changes.

  ## Examples

      iex> change_job(job)
      %Ecto.Changeset{data: %Job{}}

  """
  @spec change_job(%Job{}, map()) :: Ecto.Changeset.t()
  def change_job(%Job{} = job, attrs \\ %{}) do
    Job.changeset(job, attrs)
  end
end
