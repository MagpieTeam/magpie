defmodule Magpie.DataAccess.Logger do
  import Magpie.DataAccess.Util
  
  def get do
    {:ok, client} = :cqerl.new_client()
    {:ok, result} = :cqerl.run_query(client, "SELECT id, name, password FROM magpie.loggers;")

    # TODO: unpack like measurements if more than 100
    loggers = :cqerl.all_rows(result)

    Enum.map(loggers, &to_logger/1)
  end

  def get(id) do
    {:ok, client} = :cqerl.new_client()

    query = cql_query(
      statement: "SELECT id, name, password FROM magpie.loggers WHERE id = ?;",
      values: [id: :uuid.string_to_uuid(id)])
    {:ok, result} = :cqerl.run_query(client, query)
    case :cqerl.next(result) do
      {row, next_result} ->
        :cqerl.close_client(client)
        {:ok, to_logger(row)}
      :empty_dataset -> {:error, "Not found"}
    end
  end

  defp to_logger(l) do
    [id: :uuid.uuid_to_string(l[:id]), name: l[:name], password: l[:password]]
  end
end