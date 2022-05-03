defmodule DoctorScheduleWeb.Api.ResetPasswordController do
  alias DoctorSchedule.Accounts.Services.ResetPasswordService

  use DoctorScheduleWeb, :controller

  action_fallback DoctorScheduleWeb.FallbackController

  def create(conn, %{"token" => token, "data" => data}) do
    with {:ok, _message} <- ResetPasswordService.execute(token, data) do
      conn
      |> put_status(:no_content)
      |> put_resp_header("content-type", "application/json")
      |> text("")
    end
  end
end
