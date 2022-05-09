defmodule DoctorScheduleWeb.Api.AppoitmentControllerTest do
  use DoctorScheduleWeb.ConnCase

  import DoctorSchedule.AppointmentsFixtures

  alias DoctorSchedule.Appointments.Appoitment

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
    test "lists all appoiontments", %{conn: conn} do
      conn = get(conn, Routes.api_appoitment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create appoitment" do
    test "renders appoitment when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_appoitment_path(conn, :create), appoitment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_appoitment_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "date" => "2022-05-08T16:23:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_appoitment_path(conn, :create), appoitment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update appoitment" do
    setup [:create_appoitment]

    test "renders appoitment when data is valid", %{
      conn: conn,
      appoitment: %Appoitment{id: id} = appoitment
    } do
      conn =
        put(conn, Routes.api_appoitment_path(conn, :update, appoitment), appoitment: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_appoitment_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "date" => "2022-05-09T16:23:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, appoitment: appoitment} do
      conn =
        put(conn, Routes.api_appoitment_path(conn, :update, appoitment),
          appoitment: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete appoitment" do
    setup [:create_appoitment]

    test "deletes chosen appoitment", %{conn: conn, appoitment: appoitment} do
      conn = delete(conn, Routes.api_appoitment_path(conn, :delete, appoitment))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_appoitment_path(conn, :show, appoitment))
      end
    end
  end

  defp create_appoitment(_) do
    appoitment = appoitment_fixture()
    %{appoitment: appoitment}
  end
end
