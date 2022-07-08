defmodule DoctorSchedule.Appointments.Repositories.AppointmentRepository do
  @moduledoc """
  The Appointments context.
  """

  import Ecto.Query, warn: false
  alias DoctorSchedule.Repo

  alias DoctorSchedule.Appointments.Entities.Appointment

  def find_by_appointment_date_and_provider(date, provider_id),
    do: Repo.get_by(Appointment, date: date, provider_id: provider_id)

  @doc """
  Returns the list of appointments.

  ## Examples

      iex> list_appointments()
      [%Appointment{}, ...]

  """
  def list_appointments do
    Repo.all(Appointment)
  end

  @doc """
  Gets a single appointment.

  Raises `Ecto.NoResultsError` if the Appointment does not exist.

  ## Examples

      iex> get_appointment!(123)
      %Appointment{}

      iex> get_appointment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_appointment!(id), do: Repo.get!(Appointment, id)

  @doc """
  Creates a appointment.

  ## Examples

      iex> create_appointment(%{field: value})
      {:ok, %Appointment{}}

      iex> create_appointment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_appointment(attrs \\ %{}) do
    %Appointment{}
    |> Appointment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a appointment.

  ## Examples

      iex> update_appointment(appointment, %{field: new_value})
      {:ok, %Appointment{}}

      iex> update_appointment(appointment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_appointment(%Appointment{} = appointment, attrs) do
    appointment
    |> Appointment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a appointment.

  ## Examples

      iex> delete_appointment(appointment)
      {:ok, %Appointment{}}

      iex> delete_appointment(appointment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_appointment(%Appointment{} = appointment) do
    Repo.delete(appointment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking appointment changes.

  ## Examples

      iex> change_appointment(appointment)
      %Ecto.Changeset{data: %Appointment{}}

  """
  def change_appointment(%Appointment{} = appointment, attrs \\ %{}) do
    Appointment.changeset(appointment, attrs)
  end

  def monthly_schedule_from_provider(provider_id, year, month) do
    {:ok, start_date} = Date.new(year, month, 01)
    days = Date.days_in_month(start_date)
    {:ok, end_date} = Date.new(year, month, days)

    {:ok, start_date} = NaiveDateTime.new(start_date, ~T[00:00:00.000])
    {:ok, end_date} = NaiveDateTime.new(end_date, ~T[23:59:59.999])

    query = from a in Appointment,
      where:
        a.provider_id == ^provider_id and
        (a.date >= ^start_date and a.date <= ^end_date)

    Repo.all(query)
  end
end
