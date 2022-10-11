defmodule DoctorScheduleWeb.Api.ProviderMonthAvailabilityControllerTest do
  use DoctorScheduleWeb.ConnCase

  import DoctorScheduleWeb.Auth.Guardian
  import DoctorSchedule.UserFixtures

  setup %{conn: conn} do
    user = create_user()
    {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "bearer " <> token)

    {:ok, conn: conn, user_id: user.id}
  end

  test "lists show all monthly appointments", %{conn: conn} do
    provider = create_provider()

    conn =
      get(conn, Routes.api_provider_month_availability_path(conn, :show, provider.id), %{
        year: 2022,
        month: 01
      })

    assert length(json_response(conn, 200)) > 0
  end
end
