defmodule DoctorSchedule.UserFixtures do
  def valid_user,
    do: %{
      email: "some@email",
      first_name: "some first_name",
      last_name: "some last_name",
      password: "some password",
      password_confirmation: "some password"
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
end
