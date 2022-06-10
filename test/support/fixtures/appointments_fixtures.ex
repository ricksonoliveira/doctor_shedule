defmodule DoctorSchedule.AppointmentsFixtures do
  alias DoctorSchedule.Accounts.Repositories.AccountRepository
  alias DoctorSchedule.UserFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `DoctorSchedule.Appointments` context.
  """

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    {:ok, user} = AccountRepository.create_user(UserFixtures.valid_user())
    {:ok, provider} = AccountRepository.create_user(UserFixtures.provider_user())

    {:ok, appointment} =
      attrs
      |> Enum.into(%{
        date: ~N[2022-05-08 16:23:00],
        provider_id: provider.id,
        user_id: user.id
      })
      |> DoctorSchedule.Appointments.create_appointment()

    appointment
  end
end
