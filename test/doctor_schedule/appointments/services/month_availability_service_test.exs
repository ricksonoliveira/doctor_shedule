defmodule DoctorSchedule.Appointments.Services.MonthAvailabilityServiceTest do
  use DoctorSchedule.DataCase, async: true

  alias DoctorSchedule.{
    Appointments.Services.MonthAvailabilityService,
    UserFixtures
  }

  test "should return all available schedule of a month" do
    provider = UserFixtures.create_provider()
    day_available_hours = MonthAvailabilityService.execute(provider.id, 2017, 12)

    assert Enum.any?(day_available_hours, & &1.available == true) == false
  end
end
