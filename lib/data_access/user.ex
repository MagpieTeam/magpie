defmodule Magpie.DataAccess.User do
  import Magpie.DataAccess.Util

  def get do
    {:ok, client} = :cqerl.new_client()
    {:ok, result} = :cqerl.run_query(client, "SELECT * FROM magpie.users")

    users = :cqerl.all_rows(result)

    Enum.map(users, &to_user/1)
  end

  def get(email) do
    {:ok, client} = new_client()

    query = cql:query(
      statement: "SELECT email, username, admin, password FROM magpie.users WHERE id = ?;",
      values: [email: email])
    {:ok, result} = :cqerl.run_query(client, query)
    case :cqerl.next(result) do
      {row, next_result} ->
        :cqerl.close_client(client)
        {:ok, to_user(row)}
      :empty_dataset -> {:error, "Not found"}
    end
  end

  defp to_user(u) do
    [username: u[:username], password: u[:password], email: u[:email], admin: u[:admin]]
  end
end