defmodule DoctorScheduleWeb.Api.SessionController do
  alias DoctorScheduleWeb.Auth.Guardian

  use DoctorScheduleWeb, :controller

  @user %{
    email: "kaka@mail.com",
    first_name: "khaleesi",
    id: "e657f316-5ecf-488c-84b1-64d72d8b6768",
    inserted_at: ~N[2022-04-07 19:51:06],
    last_name: "Oliveira",
    password: nil,
    password_confirmation: nil,
    password_hash: "$argon2id$v=19$m=65536,t=8,p=2$MxqDo7BvMpbXLxXueM3HfQ$DPN8YA6CTuAS7snB11fcZW6qNfgxEe30VOXxHO7zZHc",
    role: "admin",
    updated_at: ~N[2022-04-07 19:51:06]
  }

  action_fallback DoctorScheduleWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("show.json", %{user: @user, token: token})
    end
  end
end
