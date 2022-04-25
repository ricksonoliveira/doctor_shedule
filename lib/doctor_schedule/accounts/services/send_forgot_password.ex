defmodule DoctorSchedule.Accounts.Services.SendForgotPassword do
  alias DoctorSchedule.Accounts.Entities.User
  alias DoctorSchedule.Repo

  def execute(email) do
    {:ok, "_user", "_token", email}
  end
end
