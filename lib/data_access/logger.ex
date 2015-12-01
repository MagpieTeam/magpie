defmodule Magpie.DataAccess.Logger do
  
  def get do
    {:ok, client} = :cqerl.new_client()
    {:ok, result} = :cqerl.run_query(client, "SELECT * FROM magpie.loggers;")

    loggers = :cqerl.all_rows(result)

    Enum.map(loggers, &to_logger/1)
  end

  def get(id) do
    {:ok, client} = :cqerl.new_client()
    {:ok, result} = :cqerl.run_query(client, "SELECT * FROM magpie.loggers WHERE id = #{id};")

    [logger | _] = :cqerl.all_rows(result)

    to_logger(logger)
  end

  defp to_logger(l) do
    [id: :uuid.uuid_to_string(l[:id]), name: l[:name]]
  end
end