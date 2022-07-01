defmodule DoctorSchedule.AppointmentsFixtures do
  alias DoctorSchedule.Appointments.Repositories.AppointmentRepository
  alias DoctorSchedule.UserFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `DoctorSchedule.Appointments` context.
  """

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(user_id \\ nil) do
    {:ok, appointment} =
      %{
        date: ~N[2022-05-08 16:23:00],
        provider_id: UserFixtures.create_provider().id,
        user_id: user_id || UserFixtures.create_user().id
      }
      |> AppointmentRepository.create_appointment()

    appointment
  end
end
