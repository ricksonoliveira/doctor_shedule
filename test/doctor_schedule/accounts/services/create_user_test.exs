defmodule DoctorSchedule.Accounts.Services.CreateUserTest do
  use DoctorSchedule.DataCase

  alias DoctorSchedule.Accounts.Services.CreateUser

  test "should create a provider with and without cache" do
    user_provider = %{
      "email" => "provider@email",
      "first_name" => "provider first_name",
      "last_name" => "provider last_name",
      "password" => "123123",
      "password_confirmation" => "123123",
      "role" => "admin"
    }

    assert {:ok, provider} = CreateUser.execute(user_provider)
    assert provider.email == "provider@email"
  end
end
