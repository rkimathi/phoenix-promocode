defmodule BraveWeb.CodeController do
  use BraveWeb, :controller

  alias Brave.Promo
  alias Brave.Promo.Code

  action_fallback BraveWeb.FallbackController

  def index(conn, _params) do
    codes = Promo.list_codes()
    render(conn, "index.json", codes: codes)
  end

  def create(conn, %{"code" => code_params}) do
    with {:ok, %Code{} = code} <- Promo.create_code(code_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.code_path(conn, :show, code))
      |> render("show.json", code: code)
    end
  end

  def show(conn, %{"id" => id}) do
    code = Promo.get_code!(id)
    render(conn, "show.json", code: code)
  end

  def update(conn, %{"id" => id, "code" => code_params}) do
    code = Promo.get_code!(id)

    with {:ok, %Code{} = code} <- Promo.update_code(code, code_params) do
      render(conn, "show.json", code: code)
    end
  end

  def delete(conn, %{"id" => id}) do
    code = Promo.get_code!(id)

    with {:ok, %Code{}} <- Promo.delete_code(code) do
      send_resp(conn, :no_content, "")
    end
  end
end
