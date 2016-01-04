defmodule Magpie.DataAccess.Util do
  require Record
  Record.defrecord(:cql_query_batch, Record.extract(:cql_query_batch, from: "lib/include/cqerl.hrl"))
  Record.defrecord(:cql_query, Record.extract(:cql_query, from: "lib/include/cqerl.hrl"))

  def get_stream(query) do
    Stream.resource(
      fn() ->
        {:ok, client} = :cqerl.new_client()
        {:ok, result} = :cqerl.run_query(client, query)
        result
      end,
      fn(result) ->
        case :cqerl.next(result) do
          {row, next_result} ->
            {[row], next_result}
          :empty_dataset ->
            case :cqerl.fetch_more(result) do
              {:ok, next_result} ->
                case :cqerl.next(next_result) do
                  {row, next_result} -> {[row], next_result}
                  :empty_dataset ->
                    {:halt, result}
                end
              :no_more_result ->
                {:halt, result}
            end
        end
      end,
      fn(result) ->
        client = elem(result, 4)
        :ok = :cqerl.close_client(client)
      end
    )
  end
end