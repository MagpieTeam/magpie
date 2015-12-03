defmodule Magpie.DataAccess.User do
  import Magpie.DataAccess.Util

  def get do
    {:ok, client} = :cqerl.new_client()
    {:ok, result} = :cqerl.run_query(client, "SELECT * FROM magpie.users")

    users = :cqerl.all_rows(result)

    Enum.map(users, &to_user/1)
end

  defp to_user(u) do
    [username: u[:username], password: u[:password], mail: u[:mail], admin: u[:admin]]
  end
end