defmodule DoctorSchedule.Appointments.Services.CreateAppointmentTest do
  use DoctorSchedule.DataCase, async: true

  alias DoctorSchedule.{
    Appointments.Entities.Appointment,
    Appointments.Repositories.AppointmentRepository,
    Appointments.Services.CreateAppointment,
    UserFixtures
  }

  import Mock

  test "should throw an error when date is in the past" do
    assert {:error, "Cannot create an appointment with past date"} ==
             CreateAppointment.execute(%{
               "date" => NaiveDateTime.utc_now() |> NaiveDateTime.to_string(),
               "provider_id" => 123,
               "user_id" => 123
             })
  end

  test "should throw an error when doctor has the same id as the user" do
    date = NaiveDateTime.utc_now()

    date =
      %NaiveDateTime{date | day: date.day + 1}
      |> NaiveDateTime.to_string()

    assert {:error, "Cannot create an appointment with same provider and user ids."} ==
             CreateAppointment.execute(%{
               "date" => date,
               "provider_id" => 123,
               "user_id" => 123
             })
  end

  test "should throw an error when the booking is out of schedule" do
    date = NaiveDateTime.utc_now()

    date =
      %NaiveDateTime{date | day: date.day + 1, hour: 20}
      |> NaiveDateTime.to_string()

    assert {:error, "Bookings can only be made between 8am and 19pm."} ==
             CreateAppointment.execute(%{
               "date" => date,
               "provider_id" => 123,
               "user_id" => 122
             })
  end

  test "should throw an error when booking is out of schedule" do
    date = NaiveDateTime.utc_now()

    date =
      %NaiveDateTime{date | day: date.day + 1, hour: 20}
      |> NaiveDateTime.to_string()

    assert {:error, "Bookings can only be made between 8am and 19pm."} ==
             CreateAppointment.execute(%{
               "date" => date,
               "provider_id" => 123,
               "user_id" => 122
             })
  end

  test "should throw an error when booking already exists" do
    date = NaiveDateTime.utc_now()

    date =
      %NaiveDateTime{date | day: date.day + 1, hour: 15}
      |> NaiveDateTime.to_string()

    with_mocks [
      {AppointmentRepository, [],
       [find_by_appointment_date_and_provider: fn _, _ -> "Passed the not nil test" end]}
    ] do
      assert {:error, "This appointment is already booked."} ==
               CreateAppointment.execute(%{
                 "date" => date,
                 "provider_id" => 123,
                 "user_id" => 122
               })
    end
  end

  test "should successfully create an appointment" do
    date = NaiveDateTime.utc_now()

    date =
      %NaiveDateTime{date | day: date.day + 1, hour: 15}
      |> NaiveDateTime.to_string()

    provider = UserFixtures.create_provider()
    user = UserFixtures.create_user()

    assert {:ok, %Appointment{} = appointment} =
             CreateAppointment.execute(%{
               "date" => date,
               "provider_id" => provider.id,
               "user_id" => user.id
             })

    assert user.id == appointment.user_id
  end
end
