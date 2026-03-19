defmodule AtsWeb.Api.SessionController do
  use AtsWeb, :controller

  alias Ats.Accounts

  action_fallback AtsWeb.FallbackController

  @doc """
  Create a new session (login).

  Expects user email and password. Returns an auth token if credentials are valid.
  """
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    if user = Accounts.get_user_by_email_and_password(email, password) do
      token = Phoenix.Token.sign(conn, "user auth", user.id)

      conn
      |> put_status(:created)
      |> json(%{
        data: %{
          token: token,
          user: %{
            id: user.id,
            email: user.email
          }
        }
      })
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Invalid email or password"})
    end
  end

  @doc """
  Delete a session (logout).
  """
  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{data: %{message: "Logged out successfully"}})
  end
end
