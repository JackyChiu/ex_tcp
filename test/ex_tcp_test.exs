defmodule ExTcpTest do
  use ExUnit.Case
  doctest ExTcp

  test "greets the world" do
    assert ExTcp.hello() == :world
  end
end
