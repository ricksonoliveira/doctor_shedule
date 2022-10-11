defmodule DoctorSchedule.Accounts.Services.SendForgotPasswordTest do
  use DoctorSchedule.DataCase, async: true
  use Bamboo.Test

  alias DoctorSchedule.Accounts.Services.SendForgotPassword

  import DoctorSchedule.AccountsFixtures

  test "execute/2 should send email" do
    user = user_fixture()

    assert {:ok, _token, _user, email_sent} = SendForgotPassword.execute(user.email)
    assert email_sent.to == [{user.first_name, user.email}]
    assert email_sent.from == {"Doctor Schedule Team", "adm@doctorschedule.com"}
    assert email_sent.html_body =~ "Hello, #{user.first_name}!"
    assert_delivered_email(email_sent)
  end

  test "execute/2 should return error when reset no success " do
    assert {:error, "User does not exists"} == SendForgotPassword.execute("someemail@mail.com")
  end
end
