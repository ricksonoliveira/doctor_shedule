defmodule DoctorSchedule.Accounts.Repositories.TokenRepository do
  @moduledoc """
  The Token Repository context
  """
  import Ecto.Query, warn: false

  alias DoctorSchedule.Accounts.Entities.{User, UserToken}
  alias DoctorSchedule.Repo

  def get_by_token(token), do: Repo.get_by(UserToken, token: token) |> Repo.preload(:user)

  def generate(email) do
    Repo.get_by(User, email: email)
    |> case do
      nil ->
        {:error, "User does not exists"}

      user ->
        {:ok, user_token} =
          user
          |> Ecto.build_assoc(:user_tokens)
          |> UserToken.changeset()
          |> Repo.insert()

        {:ok, user_token.token, user}
    end
  end
end
