defmodule DoctorSchedule.AppointmentsTest do
  use DoctorSchedule.DataCase

  alias DoctorSchedule.Appointments

  describe "appoiontments" do
    alias DoctorSchedule.Appointments.Appoitment

    import DoctorSchedule.AppointmentsFixtures

    @invalid_attrs %{date: nil}

    test "list_appoiontments/0 returns all appoiontments" do
      appoitment = appoitment_fixture()
      assert Appointments.list_appoiontments() == [appoitment]
    end

    test "get_appoitment!/1 returns the appoitment with given id" do
      appoitment = appoitment_fixture()
      assert Appointments.get_appoitment!(appoitment.id) == appoitment
    end

    test "create_appoitment/1 with valid data creates a appoitment" do
      valid_attrs = %{date: ~N[2022-05-08 16:23:00]}

      assert {:ok, %Appoitment{} = appoitment} = Appointments.create_appoitment(valid_attrs)
      assert appoitment.date == ~N[2022-05-08 16:23:00]
    end

    test "create_appoitment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Appointments.create_appoitment(@invalid_attrs)
    end

    test "update_appoitment/2 with valid data updates the appoitment" do
      appoitment = appoitment_fixture()
      update_attrs = %{date: ~N[2022-05-09 16:23:00]}

      assert {:ok, %Appoitment{} = appoitment} =
               Appointments.update_appoitment(appoitment, update_attrs)

      assert appoitment.date == ~N[2022-05-09 16:23:00]
    end

    test "update_appoitment/2 with invalid data returns error changeset" do
      appoitment = appoitment_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Appointments.update_appoitment(appoitment, @invalid_attrs)

      assert appoitment == Appointments.get_appoitment!(appoitment.id)
    end

    test "delete_appoitment/1 deletes the appoitment" do
      appoitment = appoitment_fixture()
      assert {:ok, %Appoitment{}} = Appointments.delete_appoitment(appoitment)
      assert_raise Ecto.NoResultsError, fn -> Appointments.get_appoitment!(appoitment.id) end
    end

    test "change_appoitment/1 returns a appoitment changeset" do
      appoitment = appoitment_fixture()
      assert %Ecto.Changeset{} = Appointments.change_appoitment(appoitment)
    end
  end
end
