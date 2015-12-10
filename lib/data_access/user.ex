defmodule Magpie.DataAccess.User do
  require Logger
  import Magpie.DataAccess.Util
  alias Magpie.Contract.User
  
  def get do
    {:ok, client} = :cqerl.new_client()
    {:ok, result} = :cqerl.run_query(client, "SELECT * FROM magpie.users;")

    users = :cqerl.all_rows(result)

    Enum.map(users, &to_user/1)
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

  def put(%User{id: nil} = u) do
    id = :uuid.get_v4()
    put(%User{u | id: :uuid.uuid_to_string(id)})
  end

  def put(%User{} = u) do
    {:ok, client} = :cqerl.new_client()

    query = cql_query(
      statement: "INSERT INTO magpie.users (email, username, password, admin, id) VALUES (?,?,?,?,?);",
      values: [email: u.email, username: u.username, password: u.password, admin: u.admin , id: :uuid.string_to_uuid(u.id)])
    case :cqerl.run_query(client, query) do
      {:ok, result} ->
        :ok
      {:error, {code, msg, _}} ->
        Logger.error "#{code}: #{msg}"
        :error
    end
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
        Logger.error "#{code}: #{msg}"
        :error
    end
  end

  defp to_user(u) do
    %User{
      id: :uuid.uuid_to_string(u[:id]),
      username: to_string(u[:username]),
      email: to_string(u[:email]),
      password: to_string(u[:password]),
      admin: u[:admin],
    }
  end
end