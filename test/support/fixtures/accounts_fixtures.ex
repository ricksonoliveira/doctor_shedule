defmodule DoctorSchedule.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DoctorSchedule.Accounts` context.
  """

  alias DoctorSchedule.Accounts.Repositories.AccountRepository

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some@email",
        first_name: "some first_name",
        last_name: "some last_name",
        password: "123123",
        password_confirmation: "123123"
      })
      |> AccountRepository.create_user()

    user
  end

  def provider_fixture(attrs \\ %{}) do
    {:ok, provider} =
      attrs
      |> Enum.into(%{
        email: "provider@email",
        first_name: "provider first_name",
        last_name: "provider last_name",
        password: "123123",
        password_confirmation: "123123",
        role: "admin"
      })
      |> AccountRepository.create_user()

    provider
  end
end
