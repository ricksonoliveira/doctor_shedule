defmodule DoctorSchedule.Accounts.Entities.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias DoctorSchedule.Accounts.Entities.UserToken
  alias DoctorSchedule.Appointments.Entities.Appointment

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "users" do
    field :email, :string, unique: true
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :role, :string, default: "user"

    has_many :appointments, Appointment
    has_many :user_tokens, UserToken

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :first_name, :last_name, :role, :password, :password_confirmation])
    |> validate_required(
      [
        :email,
        :first_name,
        :last_name,
        :role,
        :password,
        :password_confirmation
      ],
      message: "Required field can't be blank"
    )
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/, message: "Invalid format: please provide a valid e-mail")
    |> update_change(:email, &String.downcase/1)
    |> validate_length(:password,
      min: 6,
      max: 100,
      message: "Password should have between 6 to 100 characters"
    )
    |> validate_confirmation(:password)
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp hash_password(changeset) do
    changeset
  end
end
