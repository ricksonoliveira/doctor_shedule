defmodule DoctorScheduleWeb.Api.ResetPasswordControllerTest do
  use DoctorScheduleWeb.ConnCase

  import DoctorSchedule.UserFixtures

  alias DoctorSchedule.Accounts.Repositories.AccountRepository
  alias DoctorSchedule.Accounts.Services.SendForgotPassword

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/json")

    {:ok, conn: conn}
  end

  test "should reset password", %{conn: conn} do
    {:ok, user} = AccountRepository.create_user(valid_user())
    {:ok, _, token} = SendForgotPassword.execute(user.email)

    conn =
      conn
      |> post(Routes.api_reset_password_path(conn, :create), %{
        token: token,
        data: %{
          password: "123456",
          password_confirmation: "123456"
        }
      })

    assert conn.status == 204
  end
end
