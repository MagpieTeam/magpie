defmodule Magpie.DataAccess.Util do
  require Record
  Record.defrecord(:cql_query_batch, Record.extract(:cql_query_batch, from: "lib/include/cqerl.hrl"))
  Record.defrecord(:cql_query, Record.extract(:cql_query, from: "lib/include/cqerl.hrl"))
end