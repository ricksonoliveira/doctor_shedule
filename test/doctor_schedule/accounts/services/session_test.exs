defmodule DoctorSchedule.Accounts.Services.SessionTest do
  use DoctorSchedule.DataCase, async: true

  alias DoctorSchedule.Accounts.Services.Session

  import DoctorSchedule.AccountsFixtures

  test "authenticate/2 should return user" do
    user_fixture()
    {:ok, user_authenticated} = Session.authenticate("some@email", "123123")
    assert "some@email" == user_authenticated.email
  end

  test "authenticate/2 should return user not_found for invalid password" do
    user_fixture()
    assert {:error, :unauthorized} == Session.authenticate("some@email", "somepass")
  end

  test "authenticate/2 should return unauthorized for invalid password" do
    user_fixture()
    result = Session.authenticate("some@aaaa", "123123")
    assert {:error, :not_found} == result
  end
end
