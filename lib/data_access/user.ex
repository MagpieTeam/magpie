defmodule Magpie.DataAccess.User do
  import Magpie.DataAccess.Util

  def get() do
    get_stream("SELECT * FROM magpie.users;")
    |>Stream.map(&to_user/1)
    |>Enum.to_list
  end

  def get(id) do
    {:ok, client} = :cqerl.new_client()

    query = cql_query(
      statement: "SELECT email, username, admin, password, id FROM magpie.users WHERE id = ?;",
      values: [id: :uuid.string_to_uuid(id)])
    {:ok, result} = :cqerl.run_query(client, query)
    case :cqerl.next(result) do
      {row, next_result} ->
        :cqerl.close_client(client)
        {:ok, to_user(row)}
      :empty_dataset -> {:error, "Not found"}
    end
  end

  def get_by_email(email) do
    {:ok, client} = :cqerl.new_client()

    query = cql_query(
      statement: "SELECT email, username, admin, password, id FROM magpie.users WHERE email = ?;",
      values: [email: email])
    {:ok, result} = :cqerl.run_query(client, query)
    case :cqerl.next(result) do
      {row, next_result} ->
        :cqerl.close_client(client)
        {:ok, to_user(row)}
      :empty_dataset -> {:error, "Not found"}
    end
  end

  def put(email, username, password, admin, id) do
    {:ok, client} = :cqerl.new_client()

    query = cql_query(
      statement: "INSERT INTO magpie.users (email, username, password, admin, id) VALUES (?,?,?,?,?);",
      values: [email: email, username: username, password: password, admin: admin , id: :uuid.string_to_uuid(id)])
    case :cqerl.run_query(client, query) do
      {:ok, result} ->
        :ok
      {:error, {code, msg, _}} ->
        User.error "#{code}: #{msg}"
        :error
    end
  end

  def put(email, username, password, admin) do
    id = :uuid.get_v4()
    put(email, username, password, admin, :uuid.uuid_to_string(id))
  end

  def delete(id) do
    {:ok, client} = :cqerl.new_client()

    query = cql_query(
      statement: "DELETE FROM magpie.users WHERE id=?;",
      values: [id: :uuid.string_to_uuid(id)])
    case :cqerl.run_query(client, query) do
      {:ok, result} ->
        :ok
      {:error, {code, msg, _}} ->
        User.error "#{code}: #{msg}"
        :error
    end
  end

  defp to_user(u) do
    [username: u[:username], password: u[:password], email: u[:email], admin: u[:admin], id: :uuid.uuid_to_string(u[:id])]
  end
end