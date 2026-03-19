defmodule AtsWeb.Api.JobController do
  use AtsWeb, :controller

  alias Ats.Jobs
  alias Ats.Jobs.Job

  action_fallback AtsWeb.FallbackController

  @doc """
  List all jobs.
  """
  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params) do
    jobs = Jobs.list_jobs()
    render(conn, :index, jobs: jobs)
  end

  @doc """
  Create a new job.

  Expects job parameters in the request body. Returns the created job.
  """
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"job" => job_params}) do
    with {:ok, %Job{} = job} <- Jobs.create_job(job_params) do
      conn
      |> put_status(:created)
      |> render(:show, job: job)
    end
  end

  @doc """
  Get a single job by ID.
  """
  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    render(conn, :show, job: job)
  end

  @doc """
  Update a job by ID.

  Expects job parameters in the request body. Returns the updated job.
  """
  @spec update(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "job" => job_params}) do
    job = Jobs.get_job!(id)

    with {:ok, %Job{} = job} <- Jobs.update_job(job, job_params) do
      render(conn, :show, job: job)
    end
  end

  @doc """
  Delete a job by ID.
  """
  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)

    with {:ok, %Job{}} <- Jobs.delete_job(job) do
      send_resp(conn, :no_content, "")
    end
  end
end
