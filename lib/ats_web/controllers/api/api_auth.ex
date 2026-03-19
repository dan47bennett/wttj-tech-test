defmodule AtsWeb.Api.ApiAuth do
  @moduledoc """
  Plug for API authentication using bearer tokens.
  """
  import Plug.Conn
  import Phoenix.Controller

  alias Ats.Accounts

  @spec init(keyword()) :: keyword()
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), keyword()) :: Plug.Conn.t()
  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case Phoenix.Token.verify(conn, "user auth", token, max_age: 86_400 * 30) do
          {:ok, user_id} ->
            user = Accounts.get_user!(user_id)
            assign(conn, :current_user, user)

          {:error, _reason} ->
            conn
            |> put_status(:unauthorized)
            |> put_view(json: AtsWeb.ErrorJSON)
            |> render(:"401")
            |> halt()
        end

      _ ->
        conn
    end
  end

  @spec require_authenticated_user(Plug.Conn.t(), keyword()) :: Plug.Conn.t()
  def require_authenticated_user(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(json: AtsWeb.ErrorJSON)
      |> render(:"401")
      |> halt()
    end
  end
end
