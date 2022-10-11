defmodule DoctorSchedule.Accounts.Services.SendForgotPasswordTest do
  use DoctorSchedule.DataCase, async: true
  use Bamboo.Test

  alias DoctorSchedule.Accounts.Services.SendForgotPassword

  import DoctorSchedule.AccountsFixtures

  test "execute/1 should execute forgor password" do
    user = user_fixture()

    assert {:ok, user_resp, _token} = SendForgotPassword.execute(user.email)
    assert user_resp.id == user.id
  end

  test "send_email/2 should send email" do
    assert email_sent =
             SendForgotPassword.send_email("123123", %{first_name: "rick", email: "rick@test.com"})

    assert email_sent.to == [{"rick", "rick@test.com"}]
    assert email_sent.from == {"Doctor Schedule Team", "adm@doctorschedule.com"}
    assert email_sent.html_body =~ "Hello, rick!"
    assert_delivered_email(email_sent)
  end

  test "execute/2 should return error when reset no success " do
    assert {:error, "User does not exists"} == SendForgotPassword.execute("someemail@mail.com")
  end
end
