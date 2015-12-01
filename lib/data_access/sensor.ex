defmodule Magpie.DataAccess.Sensor do
  import Magpie.DataAccess.Util

  def get(logger_id) do
    {:ok, client} = :cqerl.new_client()
    query = cql_query(
      statement: "SELECT id, name, unit_of_measure FROM magpie.sensors WHERE logger_id = ?;",
      values: [logger_id: :uuid.string_to_uuid(logger_id)])
    {:ok, result} = :cqerl.run_query(client, query)

    sensors = :cqerl.all_rows(result)

    Enum.map(sensors, &to_sensor/1)
  end

  def get(id, logger_id) do
    {:ok, client} = :cqerl.new_client()
    query = cql_query(
      statement: "SELECT id, name, unit_of_measure FROM magpie.sensors WHERE id = ? AND logger_id = ?;",
      values: [id: :uuid.string_to_uuid(id), logger_id: :uuid.string_to_uuid(logger_id)])
    {:ok, result} = :cqerl.run_query(client, query)
    case :cqerl.next(result) do
      {row, next_result} ->
        :cqerl.close_client(client)
        {:ok, to_sensor(row)}
      :empty_dataset -> {:error, "Not found"}
    end
  end

  defp to_sensor(s) do
    [id: :uuid.uuid_to_string(s[:id]), name: s[:name], unit_of_measure: s[:unit_of_measure]]
  end

end