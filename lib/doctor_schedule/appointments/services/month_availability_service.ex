defmodule DoctorSchedule.Appointments.Services.MonthAvailabilityService do

  alias DoctorSchedule.Appointments.Repositories.AppointmentRepository

  def execute(provider_id, year, month) do
    {:ok, date} = Date.new(year, month, 1)

    AppointmentRepository.monthly_schedule_from_provider(provider_id, year, month)

    1..Date.days_in_month(date)
    |> Enum.map(&%{day: &1, free: true})
  end
end
