defmodule DoctorSchedule.AppointmentsTest do
  use DoctorSchedule.DataCase

  alias DoctorSchedule.Appointments

  describe "appointments" do
    alias DoctorSchedule.Accounts.Repositories.AccountRepository
    alias DoctorSchedule.Appointments.Appointment

    import DoctorSchedule.AppointmentsFixtures
    import DoctorSchedule.UserFixtures

    @invalid_attrs %{date: nil}

    test "list_appointments/0 returns all appointments" do
      appointment = appointment_fixture()
      assert Appointments.list_appointments() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert Appointments.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      {:ok, user} = AccountRepository.create_user(valid_user())
      {:ok, provider} = AccountRepository.create_user(provider_user())

      valid_attrs = %{
        date: ~N[2022-05-08 16:23:00],
        user_id: user.id,
        provider_id: provider.id
      }

      assert {:ok, %Appointment{} = appointment} = Appointments.create_appointment(valid_attrs)
      assert appointment.date == ~N[2022-05-08 16:23:00]
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Appointments.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()
      update_attrs = %{date: ~N[2022-05-09 16:23:00]}

      assert {:ok, %Appointment{} = appointment} =
               Appointments.update_appointment(appointment, update_attrs)

      assert appointment.date == ~N[2022-05-09 16:23:00]
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Appointments.update_appointment(appointment, @invalid_attrs)

      assert appointment == Appointments.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = Appointments.delete_appointment(appointment)
      assert_raise Ecto.NoResultsError, fn -> Appointments.get_appointment!(appointment.id) end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = Appointments.change_appointment(appointment)
    end
  end
end
