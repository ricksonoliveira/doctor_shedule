defmodule DoctorSchedule.Repo.Migrations.CreateAppoiontments do
  use Ecto.Migration

  def change do
    create table(:appoiontments, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :date, :naive_datetime

      add :user_id,
          references(:users, on_delete: :nilify_all, on_update: :nilify_all, type: :uuid)

      add :provider_id,
          references(:users, on_delete: :nilify_all, on_update: :nilify_all, type: :uuid)

      timestamps()
    end

    create index(:appoiontments, [:user_id])
    create index(:appoiontments, [:provider_id])
  end
end
