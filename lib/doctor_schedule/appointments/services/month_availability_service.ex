defmodule DoctorSchedule.Appointments.Services.MonthAvailabilityService do
  alias DoctorSchedule.Appointments.Repositories.ProviderRepository

  def execute(provider_id, year, month) do
    {:ok, this_month} = Date.new(year, month, 1)

    monthly_appointment =
      ProviderRepository.monthly_schedule_from_provider(provider_id, year, month)

    today = Date.utc_today()

    1..Date.days_in_month(this_month)
    |> Enum.map(&%{day: &1, available: is_available?(&1, today, this_month, monthly_appointment)})
  end

  defp is_available?(day, today, this_month, monthly_appointment) do
    date = %Date{this_month | day: day}

    if Date.compare(date, today) != :lt do
      monthly_appointment
      |> Enum.filter(&(&1.date.day == day))
      |> Enum.count() < 12
    else
      false
    end
  end
end
