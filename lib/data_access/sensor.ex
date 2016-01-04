defmodule Magpie.DataAccess.Sensor do
  import Magpie.DataAccess.Util

  def get(logger_id) do
    {:ok, client} = :cqerl.new_client()
    query = cql_query(
      statement: "SELECT logger_id, id, name, unit_of_measure FROM magpie.sensors WHERE logger_id = ?;",
      values: [logger_id: :uuid.string_to_uuid(logger_id)])
    {:ok, result} = :cqerl.run_query(client, query)

    sensors = :cqerl.all_rows(result)

    Enum.map(sensors, &to_sensor/1)
  end

  def get(id, logger_id) do
    {:ok, client} = :cqerl.new_client()
    query = cql_query(
      statement: "SELECT logger_id, id, name, unit_of_measure FROM magpie.sensors WHERE id = ? AND logger_id = ?;",
      values: [id: :uuid.string_to_uuid(id), logger_id: :uuid.string_to_uuid(logger_id)])
    {:ok, result} = :cqerl.run_query(client, query)
    case :cqerl.next(result) do
      {row, next_result} ->
        :cqerl.close_client(client)
        {:ok, to_sensor(row)}
      :empty_dataset -> {:error, "Not found"}
    end
  end

  def set_passive(ids, logger_id) do
    {:ok, client} = :cqerl.new_client()
    query = cql_query(statement: "INSERT INTO magpie.sensors (id, logger_id, active) VALUES (?, ?, false);")
    queries = for id <- ids do
      cql_query(query, values: [id: :uuid.string_to_uuid(id), logger_id: :uuid.string_to_uuid(logger_id)])
    end
    batch_query = cql_query_batch(mode: 1, consistency: 1, queries: queries)
    {:ok, result} = :cqerl.run_query(client, batch_query)
  end

  def put(sensors, logger_id) do
    {:ok, client} = :cqerl.new_client()
    query = cql_query(statement: "INSERT INTO magpie.sensors (id, logger_id, name, unit_of_measure, active) VALUES (?, ?, ?, ?, true);")
    queries = for %{"id" => id, "name" => name, "unit_of_measure" => unit_of_measure} <- sensors do
      cql_query(query, values: [id: :uuid.string_to_uuid(id), logger_id: :uuid.string_to_uuid(logger_id), name: name, unit_of_measure: unit_of_measure])
    end
    batch_query = cql_query_batch(mode: 1, consistency: 1, queries: queries)
    {:ok, result} = :cqerl.run_query(client, batch_query)
  end

  defp to_sensor(s) do
    [
      logger_id: to_string(:uuid.uuid_to_string(s[:logger_id])),
      id: :uuid.uuid_to_string(s[:id]), 
      name: s[:name], 
      unit_of_measure: s[:unit_of_measure],
      active: s[:active]
    ]
  end
end
