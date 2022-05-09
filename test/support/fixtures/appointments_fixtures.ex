defmodule DoctorSchedule.AppointmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DoctorSchedule.Appointments` context.
  """

  @doc """
  Generate a appoitment.
  """
  def appoitment_fixture(attrs \\ %{}) do
    {:ok, appoitment} =
      attrs
      |> Enum.into(%{
        date: ~N[2022-05-08 16:23:00]
      })
      |> DoctorSchedule.Appointments.create_appoitment()

    appoitment
  end
end
