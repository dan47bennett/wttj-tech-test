defmodule AtsWeb.ErrorJSON do
  @moduledoc "JSON rendering for error responses."

  @doc """
  Render an error response with the HTTP status message from the template.

  By default, Phoenix returns the status message from the template name.
  For example, "404.json" becomes "Not Found".
  """
  @spec render(String.t(), map()) :: map()
  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
