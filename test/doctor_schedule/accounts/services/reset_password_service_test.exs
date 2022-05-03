defmodule DoctorSchedule.Accounts.Services.ResetPasswordServiceTest do
  use DoctorSchedule.DataCase

  alias DoctorSchedule.Accounts.Repositories.{AccountRepository, TokenRepository}
  alias DoctorSchedule.Accounts.Services.{ResetPasswordService, SendForgotPassword}

  import DoctorSchedule.AccountsFixtures
  import Mock

  test "authenticate/2 should return user" do
    user = user_fixture()
    {:ok, token, _} = TokenRepository.generate(user.email)

    assert {:ok, "Password has been updated!"} ==
             ResetPasswordService.execute(token, %{
               password: "123123",
               password_confirmation: "123123"
             })
  end
end
