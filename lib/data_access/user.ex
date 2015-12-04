defmodule Magpie.DataAccess.User do
  import Magpie.DataAccess.Util

  def get do
    {:ok, client} = :cqerl.new_client()
    {:ok, result} = :cqerl.run_query(client, "SELECT user_id, username, password, admin, email FROM magpie.users;")

    users = :cqerl.all_rows(result)

    Enum.map(users, &to_user/1)
  end

  def get(id) do
    {:ok, client} = :cqerl.new_client()

    query = cql_query(
      statement: "SELECT email, username, admin, password, user_id FROM magpie.users WHERE user_id = ?;",
      values: [id: id])
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
      statement: "INSERT INTO magpie.users (email, username, password, admin, user_id) VALUES (?,?,?,?,?);",
      values: [email: email, username: username, password: password, admin: admin, id: :uuid.string_to_uuid(id)])
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
    put(email, username, password, admin, id)
  end

  def delete(id) do
    {:ok, client} = :cqerl.new_client()

    query = cql_query(
      statement: "DELETE FROM magpie.users WHERE user_id=?;",
      values: [id: id])
    case :cqerl.run_query(client, query) do
      {:ok, result} ->
        :ok
      {:error, {code, msg, _}} ->
        User.error "#{code}: #{msg}"
        :error
    end
  end

  defp to_user(u) do
    [username: u[:username], password: u[:password], email: u[:email], admin: u[:admin], id: u[:user_id]]
  end
end