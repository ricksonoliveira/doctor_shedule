defmodule DoctorScheduleWeb.Api.AppointmentControllerTest do
  use DoctorScheduleWeb.ConnCase

  import DoctorSchedule.AppointmentsFixtures

  alias DoctorSchedule.Appointments.Appointment

  @create_attrs %{
    date: ~N[2022-05-08 16:23:00]
  }
  @update_attrs %{
    date: ~N[2022-05-09 16:23:00]
  }
  @invalid_attrs %{date: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all appointments", %{conn: conn} do
      conn = get(conn, Routes.api_appointment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create appointment" do
    test "renders appointment when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_appointment_path(conn, :create), appointment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_appointment_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "date" => "2022-05-08T16:23:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_appointment_path(conn, :create), appointment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update appointment" do
    setup [:create_appointment]

    test "renders appointment when data is valid", %{
      conn: conn,
      appointment: %Appointment{id: id} = appointment
    } do
      conn =
        put(conn, Routes.api_appointment_path(conn, :update, appointment),
          appointment: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_appointment_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "date" => "2022-05-09T16:23:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, appointment: appointment} do
      conn =
        put(conn, Routes.api_appointment_path(conn, :update, appointment),
          appointment: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete appointment" do
    setup [:create_appointment]

    test "deletes chosen appointment", %{conn: conn, appointment: appointment} do
      conn = delete(conn, Routes.api_appointment_path(conn, :delete, appointment))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_appointment_path(conn, :show, appointment))
      end
    end
  end

  defp create_appointment(_) do
    appointment = appointment_fixture()
    %{appointment: appointment}
  end
end
