defmodule Magpie.Password do
  import Comeonin.Bcrypt

  def hash_password(password) do
    hashpwsalt(password)
  end

  def verify_password(password, hash) do
    checkpw(password, hash)
  end

end