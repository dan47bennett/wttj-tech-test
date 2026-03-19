defmodule AtsWeb.HealthController do
  use AtsWeb, :controller

  @doc """
  Health check endpoint.

  Returns the server status and current timestamp.
  """
  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params) do
    json(conn, %{status: "ok", timestamp: DateTime.utc_now()})
  end
end
