defmodule DoctorSchedule.Appointments.Services.CreateAppointment do
  alias DoctorSchedule.Appointments

  def execute(appointment) do
    %{
      "date" => date,
      "provider_id" => provider_id,
      "user_id" => user_id
    } = appointment

    date =
      date
      |> start_hour()

    cond do
      is_before?(date) ->
        {:error, "Cannot create an appointment with past date"}

      provider_id == user_id ->
        {:error, "Cannot create an appointment with same provider and user ids."}

      true ->
        Appointments.create_appointment(appointment)
    end
  end

  defp is_before?(date) do
    NaiveDateTime.utc_now()
    |> NaiveDateTime.compare(date) == :gt
  end

  defp start_hour(date) do
    date =
      date
      |> NaiveDateTime.from_iso8601!()

    %NaiveDateTime{date | minute: 0, second: 0, microsecond: {0, 0}}
  end
end
