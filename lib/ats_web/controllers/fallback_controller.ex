defmodule AtsWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  This module uses Phoenix's `:action_fallback` to convert error tuples
  from context functions into appropriate HTTP responses.

  The `call/2` function has multiple clauses to handle different error types:
  - `{:error, %Ecto.Changeset{}}` - Validation errors (422 Unprocessable Entity)
  - `{:error, :not_found}` - Resource not found (404 Not Found)
  - `{:error, :unauthorized}` - Unauthorized access (401 Unauthorized)
  """

  use AtsWeb, :controller

  @spec call(
          Plug.Conn.t(),
          {:error, Ecto.Changeset.t()} | {:error, :not_found} | {:error, :unauthorized}
        ) :: Plug.Conn.t()

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: AtsWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: AtsWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(json: AtsWeb.ErrorJSON)
    |> render(:"401")
  end
end
