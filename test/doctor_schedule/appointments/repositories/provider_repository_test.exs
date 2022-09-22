defmodule DoctorSchedule.Appointments.Repositories.ProviderRepositoryTest do
  use DoctorSchedule.DataCase, async: true

  alias DoctorSchedule.{
    Appointments.Repositories.ProviderRepository,
    AppointmentsFixtures,
    Repo
  }

  describe "Test Repository in Appointments" do
    test "all_day_from_provider/2 returns all appointments from provider in a day" do
      appointment =
        AppointmentsFixtures.appointment_fixture()
        |> Repo.preload(:provider)

      date = NaiveDateTime.to_date(appointment.date)

      assert ProviderRepository.all_day_from_provider(
               appointment.provider.id,
               date
             )
             |> Enum.count() == 1
    end

    test "monthly_schedule_from_provider/3 returns all appointments from provider in a month" do
      appointment =
        AppointmentsFixtures.appointment_fixture()
        |> Repo.preload(:provider)

      year = appointment.date.year
      month = appointment.date.month

      assert ProviderRepository.monthly_schedule_from_provider(
               appointment.provider.id,
               year,
               month
             )
             |> Enum.count() == 1
    end
  end
end
