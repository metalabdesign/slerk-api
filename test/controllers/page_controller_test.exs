defmodule SlerkAPI.PageControllerTest do
  use SlerkAPI.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
