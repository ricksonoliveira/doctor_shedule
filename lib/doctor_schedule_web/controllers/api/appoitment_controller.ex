defmodule DoctorScheduleWeb.Api.AppoitmentController do
  use DoctorScheduleWeb, :controller

  alias DoctorSchedule.Appointments
  alias DoctorSchedule.Appointments.Appoitment

  action_fallback DoctorScheduleWeb.FallbackController

  def index(conn, _params) do
    appoiontments = Appointments.list_appoiontments()
    render(conn, "index.json", appoiontments: appoiontments)
  end

  def create(conn, %{"appoitment" => appoitment_params}) do
    with {:ok, %Appoitment{} = appoitment} <- Appointments.create_appoitment(appoitment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_appoitment_path(conn, :show, appoitment))
      |> render("show.json", appoitment: appoitment)
    end
  end

  def show(conn, %{"id" => id}) do
    appoitment = Appointments.get_appoitment!(id)
    render(conn, "show.json", appoitment: appoitment)
  end

  def update(conn, %{"id" => id, "appoitment" => appoitment_params}) do
    appoitment = Appointments.get_appoitment!(id)

    with {:ok, %Appoitment{} = appoitment} <-
           Appointments.update_appoitment(appoitment, appoitment_params) do
      render(conn, "show.json", appoitment: appoitment)
    end
  end

  def delete(conn, %{"id" => id}) do
    appoitment = Appointments.get_appoitment!(id)

    with {:ok, %Appoitment{}} <- Appointments.delete_appoitment(appoitment) do
      send_resp(conn, :no_content, "")
    end
  end
end
