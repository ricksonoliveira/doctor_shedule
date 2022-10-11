defmodule DoctorSchedule.Appointments.Services.DayAvailabilityServiceTest do
  use DoctorSchedule.DataCase, async: true

  alias DoctorSchedule.{
    Appointments.Services.DayAvailabilityService,
    UserFixtures
  }

  test "should return all available schedule of a day" do
    provider = UserFixtures.create_provider()

    date = Date.utc_today()
    date = %Date{date | day: date.day - 1}
    day_available_hours = DayAvailabilityService.execute(provider.id, date)

    assert Enum.any?(day_available_hours, &(&1.available == true)) == false
  end
end
