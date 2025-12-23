defmodule DoctorSchedule.Appointments.Services.DayAvailabilityServiceTest do
  use DoctorSchedule.DataCase, async: true

  import Mock

  alias DoctorSchedule.Shared.Cache.Ets.Implementations.ScheduleCache

  alias DoctorSchedule.{
    Appointments.Services.DayAvailabilityService,
    UserFixtures
  }

  test "should return all available schedule of a day" do
    provider = UserFixtures.create_provider()

    date = Date.utc_today()
    date = %Date{date | day: date.day - 1}

    with_mock ScheduleCache, get: fn _ -> {:ok, [%{available: false, hour: 8}]} end do
      day_available_hours = DayAvailabilityService.execute(provider.id, date)
      cached_day_available_hours = DayAvailabilityService.execute(provider.id, date)

      assert Enum.any?(day_available_hours, &(&1.available == true)) == false
      assert Enum.any?(cached_day_available_hours, &(&1.available == true)) == false
    end
  end
end
