defmodule DoctorSchedule.Shared.Cache.Ets.Implementations.ScheduleCache do
  @conn :redis_server

  def get(key), do: Redix.command(@conn, ["GET", key]) |> decode_value()
  def save(key, value), do: Redix.command(@conn, ["SET", key, encode_value(value)])
  def delete(key), do: Redix.command(@conn, ["DEL", key])

  defp encode_value(value), do: value |> :erlang.term_to_binary() |> Base.encode16()
  defp decode_value({:ok, nil}), do: {:not_found, "not_found"}

  defp decode_value({:ok, value}),
    do: {:ok, value |> Base.decode16!() |> :erlang.binary_to_term()}
end
