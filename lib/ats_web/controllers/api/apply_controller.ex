defmodule AtsWeb.Api.ApplyController do
  use AtsWeb, :controller

  alias Ats.Applicants
  alias Ats.Jobs

  action_fallback AtsWeb.FallbackController

  @doc """
  Create a new job application.

  Expects application parameters in the request body. Returns success message with job ID.
  """
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"job_id" => job_id, "apply" => apply_params}) do
    job = Jobs.get_job!(job_id)

    case Applicants.create_apply(Map.merge(apply_params, %{"job_id" => job_id})) do
      {:ok, _apply} ->
        conn
        |> put_status(:created)
        |> json(%{
          data: %{
            message: "Application submitted successfully",
            job_id: job.id
          }
        })

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: translate_errors(changeset)})
    end
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
