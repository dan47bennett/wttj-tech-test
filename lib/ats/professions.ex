defmodule Ats.Professions do
  @moduledoc """
  The Professions context.
  """

  import Ecto.Query, warn: false
  alias Ats.Repo

  alias Ats.Professions.Profession

  @doc """
  Returns the list of professions.

  ## Examples

      iex> list_professions()
      [%Profession{}, ...]

  """
  @spec list_professions() :: [%Profession{}]
  def list_professions do
    Repo.all(Profession)
  end

  @doc """
  Gets a single profession.

  Raises `Ecto.NoResultsError` if the Profession does not exist.

  ## Examples

      iex> get_profession!(123)
      %Profession{}

      iex> get_profession!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_profession!(integer() | binary()) :: %Profession{}
  def get_profession!(id), do: Repo.get!(Profession, id)

  @doc """
  Creates a profession.

  ## Examples

      iex> create_profession(%{field: value})
      {:ok, %Profession{}}

      iex> create_profession(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_profession(map()) :: {:ok, %Profession{}} | {:error, Ecto.Changeset.t()}
  def create_profession(attrs \\ %{}) do
    %Profession{}
    |> Profession.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a profession.

  ## Examples

      iex> update_profession(profession, %{field: new_value})
      {:ok, %Profession{}}

      iex> update_profession(profession, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_profession(%Profession{}, map()) ::
          {:ok, %Profession{}} | {:error, Ecto.Changeset.t()}
  def update_profession(%Profession{} = profession, attrs) do
    profession
    |> Profession.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a profession.

  ## Examples

      iex> delete_profession(profession)
      {:ok, %Profession{}}

      iex> delete_profession(profession)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_profession(%Profession{}) :: {:ok, %Profession{}} | {:error, Ecto.Changeset.t()}
  def delete_profession(%Profession{} = profession) do
    Repo.delete(profession)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking profession changes.

  ## Examples

      iex> change_profession(profession)
      %Ecto.Changeset{data: %Profession{}}

  """
  @spec change_profession(%Profession{}, map()) :: Ecto.Changeset.t()
  def change_profession(%Profession{} = profession, attrs \\ %{}) do
    Profession.changeset(profession, attrs)
  end
end
