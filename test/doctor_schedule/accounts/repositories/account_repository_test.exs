defmodule DoctorSchedule.Accounts.Repositories.AccountRepositoryTest do
  use DoctorSchedule.DataCase, async: true

  alias DoctorSchedule.Accounts.Repositories.AccountRepository
  alias DoctorSchedule.UserFixtures

  describe "users" do
    alias DoctorSchedule.Accounts.Entities.User

    import DoctorSchedule.AccountsFixtures

    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, password_hash: nil, role: nil}

    test "list_users/0 returns all users" do
      user_fixture()
      assert AccountRepository.list_users() |> Enum.count() == 1
    end

    test "list_providers/0 returns all providers" do
      UserFixtures.create_provider()
      assert AccountRepository.list_providers() |> Enum.count() == 1
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert AccountRepository.get_user!(user.id).email == user.email
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        email: "some@email",
        first_name: "some first_name",
        last_name: "some last_name",
        password: "123123",
        password_confirmation: "123123"
      }

      assert {:ok, %User{} = user} = AccountRepository.create_user(valid_attrs)
      assert user.email == "some@email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert response = AccountRepository.create_user(@invalid_attrs)
      assert {:error, %Ecto.Changeset{}} = response
      {:error, changeset} = response
      assert "Required field can't be blank" in errors_on(changeset).email
      assert %{email: ["Required field can't be blank"]} = errors_on(changeset)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        email: "some_updated@email",
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        password: "some updated password",
        password_confirmation: "some updated password"
      }

      assert {:ok, %User{} = user} = AccountRepository.update_user(user, update_attrs)
      assert user.email == "some_updated@email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = AccountRepository.update_user(user, @invalid_attrs)
      assert user.email == AccountRepository.get_user!(user.id).email
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = AccountRepository.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> AccountRepository.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = AccountRepository.change_user(user)
    end
  end
end
