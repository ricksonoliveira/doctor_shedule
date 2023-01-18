defmodule DoctorSchedule.Appointments.Services.MonthAvailabilityServiceTest do
  use DoctorSchedule.DataCase, async: true

  import Mock

  alias DoctorSchedule.{
    Appointments.Repositories.AppointmentRepository,
    Appointments.Services.MonthAvailabilityService,
    UserFixtures
  }

  test "should return all available schedule of a month" do
    provider = UserFixtures.create_provider()
    day_available_hours = MonthAvailabilityService.execute(provider.id, 2017, 12)

    assert Enum.any?(day_available_hours, &(&1.available == true)) == false
  end

  test "should return all available schedule of a month when date invalid" do
    provider = UserFixtures.create_provider()
    user = UserFixtures.create_user()
    create_appointment_list(provider.id, user.id)

    with_mocks [
      {Date, [:passthrough], [utc_today: fn -> ~D[2022-10-11] end]}
    ] do
      day_available_hours = MonthAvailabilityService.execute(provider.id, 2022, 10)

      assert Enum.at(day_available_hours, 14 - 1) == %{available: false, day: 14}
    end
  end

  defp create_appointment_list(provider_id, user_id) do
    date_list()
    |> Enum.each(fn date ->
      AppointmentRepository.create_appointment(%{
        date: date,
        user_id: user_id,
        provider_id: provider_id
      })
    end)
  end

  defp date_list do
    Enum.map(08..20, &NaiveDateTime.new!(2022, 10, 14, &1, 00, 00))
  end
end
