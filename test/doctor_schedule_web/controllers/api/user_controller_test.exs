defmodule DoctorScheduleWeb.Api.UserControllerTest do
  use DoctorScheduleWeb.ConnCase

  import DoctorSchedule.AccountsFixtures
  import DoctorScheduleWeb.Auth.Guardian
  import DoctorSchedule.UserFixtures

  alias DoctorSchedule.Accounts.{Entities.User, Repositories.AccountRepository}

  def fixture(:user) do
    {:ok, user} = AccountRepository.create_user(valid_user())
    user
  end

  setup %{conn: conn} do
    assert {:ok, user} =
             %{
               email: "auth@email",
               first_name: "some first_name",
               last_name: "some last_name",
               password: "some password",
               password_confirmation: "some password"
             }
             |> AccountRepository.create_user()

    assert {:ok, _user} =
             %{
               email: "provider@email",
               first_name: "provider first_name",
               last_name: "provider last_name",
               password: "provider password",
               password_confirmation: "provider password",
               role: "admin"
             }
             |> AccountRepository.create_user()

    {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "bearer " <> token)

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn =
        conn
        |> get(Routes.api_user_path(conn, :index))

      assert json_response(conn, 200) |> Enum.count() == 2
    end

    test "lists all providers", %{conn: conn} do
      conn =
        conn
        |> get(Routes.api_user_path(conn, :index), %{only_providers: 1})

      assert json_response(conn, 200) |> Enum.count() == 1
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_user_path(conn, :create), user: valid_user())
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.api_user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some@email",
               "first_name" => "some first_name",
               "last_name" => "some last_name"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_user_path(conn, :create), user: invalid_user())
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.api_user_path(conn, :update, user), user: update_user())
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, Routes.api_user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some-updated@email",
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.api_user_path(conn, :update, user), user: invalid_user())
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.api_user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
