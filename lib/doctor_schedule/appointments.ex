defmodule DoctorSchedule.Appointments do
  @moduledoc """
  The Appointments context.
  """

  import Ecto.Query, warn: false
  alias DoctorSchedule.Repo

  alias DoctorSchedule.Appointments.Appoitment

  @doc """
  Returns the list of appoiontments.

  ## Examples

      iex> list_appoiontments()
      [%Appoitment{}, ...]

  """
  def list_appoiontments do
    Repo.all(Appoitment)
  end

  @doc """
  Gets a single appoitment.

  Raises `Ecto.NoResultsError` if the Appoitment does not exist.

  ## Examples

      iex> get_appoitment!(123)
      %Appoitment{}

      iex> get_appoitment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_appoitment!(id), do: Repo.get!(Appoitment, id)

  @doc """
  Creates a appoitment.

  ## Examples

      iex> create_appoitment(%{field: value})
      {:ok, %Appoitment{}}

      iex> create_appoitment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_appoitment(attrs \\ %{}) do
    %Appoitment{}
    |> Appoitment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a appoitment.

  ## Examples

      iex> update_appoitment(appoitment, %{field: new_value})
      {:ok, %Appoitment{}}

      iex> update_appoitment(appoitment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_appoitment(%Appoitment{} = appoitment, attrs) do
    appoitment
    |> Appoitment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a appoitment.

  ## Examples

      iex> delete_appoitment(appoitment)
      {:ok, %Appoitment{}}

      iex> delete_appoitment(appoitment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_appoitment(%Appoitment{} = appoitment) do
    Repo.delete(appoitment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking appoitment changes.

  ## Examples

      iex> change_appoitment(appoitment)
      %Ecto.Changeset{data: %Appoitment{}}

  """
  def change_appoitment(%Appoitment{} = appoitment, attrs \\ %{}) do
    Appoitment.changeset(appoitment, attrs)
  end
end
