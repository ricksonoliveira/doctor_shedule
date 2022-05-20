defmodule DoctorScheduleWeb.Api.PasswordForgotController do
  alias DoctorSchedule.Accounts.Services.SendForgotPassword

  use DoctorScheduleWeb, :controller

  action_fallback DoctorScheduleWeb.FallbackController

  def create(conn, %{"email" => email}) do
    with {:ok, _user, _token, _email} <- SendForgotPassword.execute(email) do
      conn
      |> put_status(:no_content)
      |> put_resp_header("content-type", "application/json")
      |> text("")
    end
  end
end
