defmodule DoctorScheduleWeb.Api.ProviderDayAvailabilityControllerTest do
  use DoctorScheduleWeb.ConnCase

  import DoctorScheduleWeb.Auth.Guardian
  import DoctorSchedule.UserFixtures
  import Mock

  setup %{conn: conn} do
    user = create_user()
    {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "bearer " <> token)

    {:ok, conn: conn, user_id: user.id}
  end

  test "lists show all appointments of a day", %{conn: conn} do
    provider = create_provider()

    with_mock Redix, command: fn _, _ -> {:ok, nil} end do
      conn =
        get(
          conn,
          Routes.api_provider_day_availability_path(conn, :show, provider.id, "2022-01-01")
        )

      assert length(json_response(conn, 200)) > 0
    end
  end
end
