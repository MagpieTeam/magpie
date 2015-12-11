defmodule Magpie.DataAccess.Measurement do
  use Timex
  import Magpie.DataAccess.Util

  def put(measurements) do
    {:ok, client} = :cqerl.new_client()
    query = cql_query(statement: "INSERT INTO magpie.measurements (sensor_id, date, timestamp, metadata, value) VALUES (?, ?, ?, ?, ?);")
    queries = for %{"sensor_id" => sensor_id, "timestamp" => timestamp, "metadata" => metadata, "value" => value} <- measurements do
      timestamp = String.to_integer(timestamp)
      date =
        timestamp
        |> Kernel.*(1000)
        |> Timex.Date.from(:us)
        |> Timex.Date.set([hour: 0, minute: 0, second: 0, ms: 0, validate: false])
        |> Timex.DateFormat.format!("{s-epoch}")
        |> String.to_integer()
        |> Kernel.*(1000)
      {value, _} = Float.parse(value)
      cql_query(query, values: [sensor_id: :uuid.string_to_uuid(sensor_id), date: date, timestamp: timestamp, metadata: metadata, value: value])
    end
    batch_query = cql_query_batch(mode: 1, consistency: 1, queries: queries)
    {:ok, result} = :cqerl.run_query(client, batch_query)
    {:ok, measurements}
  end
  
  def get(sensor_id, from, to) do
    dates = get_dates(from, to, [])
    
    Enum.reduce(dates, [], fn (date, acc) -> 
      {:ok, day} = DateFormat.format(date, "{YYYY}/{0M}/{0D} {h24}:{m}:{s}")
      IO.inspect(day)
      get(sensor_id, day) ++ acc
    end)
  end

  def get(sensor_id, date) do
    date = 
      DateFormat.format!(date, "{s-epoch}")
      |> String.to_integer()
      |> Kernel.*(1000)

    {:ok, client} = :cqerl.new_client()  
    query = cql_query(
      statement: "SELECT sensor_id, date, timestamp, value, metadata FROM magpie.measurements WHERE sensor_id = ? AND date = ? ORDER BY timestamp DESC;",
      values: [sensor_id: :uuid.string_to_uuid(sensor_id), date: date]
    )
    {:ok, result} = :cqerl.run_query(client, query)

    unpack([], result)
  end

  def get(sensor_id, date, from, to) do
    date = 
      DateFormat.format!(date, "{s-epoch}")
      |> String.to_integer()
      |> Kernel.*(1000)

    from =
      DateFormat.format!(date, "{s-epoch}")
      |> String.to_integer()
      |> Kernel.*(1000)

    from =
      DateFormat.format!(date, "{s-epoch}")
      |> String.to_integer()
      |> Kernel.*(1000)  

    {:ok, client} = :cqerl.new_client()  
    query = cql_query(
      statement: "SELECT sensor_id, date, timestamp, value, metadata FROM magpie.measurements WHERE sensor_id = ? AND date = ? AND timestamp > ? AND timestamp < ? ORDER BY timestamp DESC;",
      values: [sensor_id: :uuid.string_to_uuid(sensor_id), date: date, timestamp: from, timestamp: to]
    )
    {:ok, result} = :cqerl.run_query(client, query)

    unpack([], result)
  end

  def get_dates(from, to, dates) do
    case Date.compare(from, to) do
      -1 ->
        next_day = Date.add(from, Time.to_timestamp(1, :days)) 
        get_dates(next_day, to, [from | dates])
      0 -> [from | dates]
      1 -> []
    end
  end

  defp unpack(acc, result) do
    case :cqerl.next(result) do
      {row, next_result} ->
        m = to_measurement(row)
        unpack([m | acc], next_result)
      :empty_dataset ->
        case :cqerl.fetch_more(result) do
          {:ok, next_result} -> unpack(acc, next_result)
          :no_more_result -> acc
        end
    end
  end

  defp to_measurement(row) do
    [timestamp: row[:timestamp], value: row[:value]]
  end
end