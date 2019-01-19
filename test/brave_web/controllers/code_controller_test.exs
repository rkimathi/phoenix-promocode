defmodule BraveWeb.CodeControllerTest do
  use BraveWeb.ConnCase

  alias Brave.Promo
  alias Brave.Promo.Code

  @create_attrs %{
    amount: 42,
    code: "some code",
    event_location: [],
    expiry_date: ~D[2010-04-17],
    is_active: true,
    radius: 42
  }
  @update_attrs %{
    amount: 43,
    code: "some updated code",
    event_location: [],
    expiry_date: ~D[2011-05-18],
    is_active: false,
    radius: 43
  }
  @invalid_attrs %{amount: nil, code: nil, event_location: nil, expiry_date: nil, is_active: nil, radius: nil}

  def fixture(:code) do
    {:ok, code} = Promo.create_code(@create_attrs)
    code
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all codes", %{conn: conn} do
      conn = get(conn, Routes.code_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create code" do
    test "renders code when data is valid", %{conn: conn} do
      conn = post(conn, Routes.code_path(conn, :create), code: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.code_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => 42,
               "code" => "some code",
               "event_location" => [],
               "expiry_date" => "2010-04-17",
               "is_active" => true,
               "radius" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.code_path(conn, :create), code: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update code" do
    setup [:create_code]

    test "renders code when data is valid", %{conn: conn, code: %Code{id: id} = code} do
      conn = put(conn, Routes.code_path(conn, :update, code), code: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.code_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => 43,
               "code" => "some updated code",
               "event_location" => [],
               "expiry_date" => "2011-05-18",
               "is_active" => false,
               "radius" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, code: code} do
      conn = put(conn, Routes.code_path(conn, :update, code), code: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete code" do
    setup [:create_code]

    test "deletes chosen code", %{conn: conn, code: code} do
      conn = delete(conn, Routes.code_path(conn, :delete, code))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.code_path(conn, :show, code))
      end
    end
  end

  defp create_code(_) do
    code = fixture(:code)
    {:ok, code: code}
  end
end
