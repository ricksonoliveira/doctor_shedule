defmodule DoctorSchedule.Accounts.Repositories.TokenRepositoryTest do
  use DoctorSchedule.DataCase, async: true

  alias DoctorSchedule.Accounts.Repositories.TokenRepository

  import DoctorSchedule.AccountsFixtures

  test "get_by_token/1 should returns user and token" do
    user = user_fixture()
    {:ok, token, _user} = TokenRepository.generate(user.email)
    assert token == TokenRepository.get_by_token(token).token
  end

  test "generate/1 should create a token" do
    user = user_fixture()
    {:ok, _token, user_token} = TokenRepository.generate(user.email)
    assert user.first_name == user_token.first_name
  end

  test "generate/1 should not create a token when user does not exist" do
    assert {:error, "User does not exists"} ==
             TokenRepository.generate("unexistent_user@mail.com")
  end
end
