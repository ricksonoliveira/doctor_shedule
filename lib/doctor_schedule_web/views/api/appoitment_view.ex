defmodule DoctorScheduleWeb.Api.AppoitmentView do
  use DoctorScheduleWeb, :view
  alias DoctorScheduleWeb.Api.AppoitmentView

  def render("index.json", %{appoiontments: appoiontments}) do
    render_many(appoiontments, AppoitmentView, "appoitment.json")
  end

  def render("show.json", %{appoitment: appoitment}) do
    render_one(appoitment, AppoitmentView, "appoitment.json")
  end

  def render("appoitment.json", %{appoitment: appoitment}) do
    %{
      id: appoitment.id,
      date: appoitment.date
    }
  end
end
