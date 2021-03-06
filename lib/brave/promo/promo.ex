defmodule Brave.Promo do
  @moduledoc """
  The Promo context.
  """

  import Ecto.Query, warn: false
  alias Brave.Repo

  alias Brave.Promo.Code

  @doc """
  Returns the list of codes.

  ## Examples

      iex> list_codes()
      [%Code{}, ...]

  """
  def list_codes do
    Repo.all(Code)
  end

  @doc """
  Returns the list of active codes.

  ## Examples

      iex> list_active_codes()
      [%Code{}, ...]

  """
  def list_active_codes do
    Repo.all(Code |> where(is_active: true))
  end

  @doc """
  Gets a single code.

  Raises `Ecto.NoResultsError` if the Code does not exist.

  ## Examples

      iex> get_code!(123)
      %Code{}

      iex> get_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_code!(id), do: Repo.get!(Code, id)

  @doc """
  Gets a single code by the given code.

  Raises `Ecto.NoResultsError` if the Code does not exist.

  ## Examples

      iex> get_code_by_code!(123)
      %Code{}

      iex> get_code_by_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_code_by_code!(code), do: Repo.get_by!(Code, code: code)

  @doc """
  Creates a code.

  ## Examples

      iex> create_code(%{field: value})
      {:ok, %Code{}}

      iex> create_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_code(attrs \\ %{}) do
    %Code{}
    |> Code.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a code.

  ## Examples

      iex> update_code(code, %{field: new_value})
      {:ok, %Code{}}

      iex> update_code(code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_code(%Code{} = code, attrs) do
    code
    |> Code.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Code.

  ## Examples

      iex> delete_code(code)
      {:ok, %Code{}}

      iex> delete_code(code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_code(%Code{} = code) do
    Repo.delete(code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking code changes.

  ## Examples

      iex> change_code(code)
      %Ecto.Changeset{source: %Code{}}

  """
  def change_code(%Code{} = code) do
    Code.changeset(code, %{})
  end
end
