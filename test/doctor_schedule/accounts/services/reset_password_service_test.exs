defmodule DoctorSchedule.Accounts.Services.ResetPasswordServiceTest do
  use DoctorSchedule.DataCase, async: true

  alias DoctorSchedule.Accounts.Repositories.TokenRepository
  alias DoctorSchedule.Accounts.Services.ResetPasswordService

  import DoctorSchedule.AccountsFixtures
  import Mock

  test "execute/2 should update password" do
    user = user_fixture()
    {:ok, token, _} = TokenRepository.generate(user.email)

    assert {:ok, "Password has been updated!"} ==
             ResetPasswordService.execute(token, %{
               password: "123123",
               password_confirmation: "123123"
             })
  end

  test "execute/2 should return eror when token does not exists" do
    assert {:error, "Token does not exists!"} ==
             ResetPasswordService.execute("8c83470c-a7b8-412f-8ac8-b4c338ab960a", %{
               password: "123123",
               password_confirmation: "123123"
             })
  end

  test "execute/2 should return token expired" do
    user = user_fixture()
    {:ok, token, _} = TokenRepository.generate(user.email)
    now = DateTime.utc_now()
    future_date = %{now | hour: now.hour + 5}

    with_mock DateTime, utc_now: fn -> future_date end do
      assert {:error, "Token has expired!"} ==
               ResetPasswordService.execute(token, %{
                 password: "123123",
                 password_confirmation: "123123"
               })
    end
  end
end
