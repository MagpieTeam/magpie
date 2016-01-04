defmodule Magpie.DataAccess.Logger do
  import Magpie.DataAccess.Util
  require Logger
  
  def get() do
    get_stream("SELECT id, name, password FROM magpie.loggers;")
    |> Stream.map(&to_logger/1)
    |> Enum.to_list
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

  def put(name, password, id) do
    {:ok, client} = :cqerl.new_client()

    query = cql_query(
      statement: "INSERT INTO magpie.loggers (password, name, id) VALUES (?,?,?);",
      values: [name: name, password: password, id: :uuid.string_to_uuid(id)])
    case :cqerl.run_query(client, query) do
      {:ok, result} ->
        :ok
      {:error, {code, msg, _}} ->
        Logger.error "#{code}: #{msg}"
        :error
    end
  end

  def put(name, password) do
    id = :uuid.get_v4()
    put(name, password, :uuid.uuid_to_string(id))
  end

  def delete(logger_id) do
    {:ok, client} = :cqerl.new_client()

    query = cql_query(
      statement: "DELETE FROM magpie.loggers WHERE id=?;",
      values: [id: :uuid.string_to_uuid(logger_id)])
    case :cqerl.run_query(client, query) do
      {:ok, result} ->
        :ok
      {:error, {code, msg, _}} ->
        Logger.error "#{code}: #{msg}"
        :error
    end
  end



  defp to_logger(l) do
    [id: to_string(:uuid.uuid_to_string(l[:id])), name: l[:name], password: l[:password]]
  end
end