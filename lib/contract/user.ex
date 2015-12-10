defmodule Magpie.Contract.User do
  
  @type t :: %Magpie.Contract.User{
    id: String.t,
    username: String.t,
    email: String.t,
    password: String.t,
    admin: boolean
  }
  defstruct id: nil, username: nil, email: nil, password: nil, admin: false

end