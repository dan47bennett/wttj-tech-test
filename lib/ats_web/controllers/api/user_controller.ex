defmodule AtsWeb.Api.UserController do
  use AtsWeb, :controller

  alias Ats.Accounts

  action_fallback AtsWeb.FallbackController

  @doc """
  Create a new user account.

  Expects user parameters in the request body. Returns the user and an auth token.
  """
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
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

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: translate_errors(changeset)})
    end
  end

  @doc """
  Get the current authenticated user.

  Returns the user if authenticated, otherwise returns an unauthorized response.
  """
  @spec me(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def me(conn, _params) do
    user = conn.assigns[:current_user]

    if user do
      json(conn, %{
        data: %{
          id: user.id,
          email: user.email
        }
      })
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Not authenticated"})
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
