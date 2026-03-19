defmodule Ats.Professions.Profession do
  @moduledoc """
  This module provides functions for managing professions.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "professions" do
    field :category_name, :string
    field :name, :string

    timestamps()
  end

  @doc false
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
  def changeset(profession, attrs) do
    profession
    |> cast(attrs, [:name, :category_name])
    |> validate_required([:name, :category_name])
  end
end
