defmodule DoctorSchedule.Appointments.Appoitment do
  use Ecto.Schema
  import Ecto.Changeset

  alias DoctorSchedule.Accounts.Entities.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "appoiontments" do
    field :date, :naive_datetime

    belongs_to :user, User, foreign_key: :user_id, type: :binary_id
    belongs_to :provider, User, foreign_key: :provider_id, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(appoitment, attrs) do
    appoitment
    |> cast(attrs, [:date, :user_id, :provider_id])
    |> validate_required([:date, :user_id, :provider_id])
  end
end
