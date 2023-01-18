defmodule DoctorSchedule.UserFixtures do
  alias DoctorSchedule.Accounts.Repositories.AccountRepository

  def valid_user,
    do: %{
      email: "some@email",
      first_name: "some first_name",
      last_name: "some last_name",
      password: "some password",
      password_confirmation: "some password"
    }

  def provider_user,
    do: %{
      email: "provider@email",
      first_name: "provider first_name",
      last_name: "provider last_name",
      password: "provider password",
      password_confirmation: "provider password",
      role: "admin"
    }

  def update_user,
    do: %{
      email: "some-updated@email",
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      password: "some updated password",
      password_confirmation: "some updated password"
    }

  def invalid_user,
    do: %{email: nil, first_name: nil, last_name: nil, password_hash: nil, role: nil}

  def create_user do
    {:ok, user} =
      AccountRepository.create_user(%{
        email: "auth@email",
        first_name: "some first_name",
        last_name: "some last_name",
        password: "some password",
        password_confirmation: "some password"
      })

    user
  end

  def create_provider do
    {:ok, provider} = AccountRepository.create_user(provider_user())

    provider
  end
end
