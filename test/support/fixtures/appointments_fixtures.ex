defmodule DoctorSchedule.AppointmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DoctorSchedule.Appointments` context.
  """

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    {:ok, appointment} =
      attrs
      |> Enum.into(%{
        date: ~N[2022-05-08 16:23:00]
      })
      |> DoctorSchedule.Appointments.create_appointment()

    appointment
  end
end
