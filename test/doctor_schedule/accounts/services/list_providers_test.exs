defmodule DoctorSchedule.Accounts.Services.ListProvidersTest do
  use DoctorSchedule.DataCase, async: true

  alias DoctorSchedule.Accounts.Services.{CreateUser, ListProviders}

  test "should list providers with and without cache" do
    provider = %{
      email: "provider@email",
      first_name: "provider first_name",
      last_name: "provider last_name",
      password: "123123",
      password_confirmation: "123123",
      role: "admin"
    }

    assert {:ok, provider} = CreateUser.execute(provider)
    provider = provider |> Map.put(:password, nil) |> Map.put(:password_confirmation, nil)
    assert [provider] == ListProviders.execute()
    assert [provider] == ListProviders.execute()
  end
end
