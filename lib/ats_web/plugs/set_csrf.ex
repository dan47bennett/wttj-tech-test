defmodule AtsWeb.Plugs.SetCsrf do
  @moduledoc """
  Plug that sets CSRF token in response cookies.
  """
  import Plug.Conn

  @csrf_cookie_name "technical-test-csrf-token"

  @spec init(keyword()) :: keyword()
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), keyword()) :: Plug.Conn.t()
  def call(conn, _opts) do
    token = Phoenix.Controller.get_csrf_token()

    put_resp_cookie(conn, @csrf_cookie_name, token,
      domain: Application.get_env(:ats, :cookie_domain),
      http_only: false,
      secure: true
    )
  end
end
