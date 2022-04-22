defmodule DoctorScheduleWeb.Api.SessionControllerTest do
  use DoctorScheduleWeb.ConnCase

  import DoctorScheduleWeb.Auth.Guardian
  import DoctorSchedule.UserFixtures

  alias DoctorSchedule.Accounts.Repositories.AccountRepository

  def fixture(:user) do
    {:ok, user} = AccountRepository.create_user(valid_user())
    user
  end

  setup %{conn: conn} do
    {:ok, user} =
      %{
        email: "auth@email",
        first_name: "some first_name",
        last_name: "some last_name",
        password: "some password",
        password_confirmation: "some password"
      }
      |> AccountRepository.create_user()

    {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "bearer " <> token)

    {:ok, conn: conn}
  end

  describe "session scenarios" do
    test "should authenticate valid user", %{conn: conn} do
      conn =
        conn
        |> post(Routes.api_session_path(conn, :create), %{
          email: "auth@email",
          password: "some password"
        })
      assert json_response(conn, 201)["user"]["email"] == "auth@email"
    end

    test "should not authenticate invalid user", %{conn: conn} do
      conn =
        conn
        |> post(Routes.api_session_path(conn, :create), %{
          email: "auth@mail.com",
          password: "wrong password"
        })

      assert json_response(conn, 400) == %{"message" => "unauthorized"}
    end
  end
end
