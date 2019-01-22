defmodule BraveWeb.CodeController do
  use BraveWeb, :controller

  alias Brave.Promo
  alias Brave.Promo.Code

  action_fallback BraveWeb.FallbackController

  def index(conn, _params) do
    codes = Promo.list_codes()
    render(conn, "index.json", codes: codes)
  end

  def create(conn, params) do
    {amount, _} = Integer.parse(params["amount"])
    {_, expiry_date} = Date.from_iso8601(params["expiry_date"])
    event_location = Jason.decode!(params["event_location"])
    {radius, _} = Integer.parse(params["radius"])
    params = %{params | "amount" => amount, "expiry_date" => expiry_date, 
        "event_location" => event_location, "radius" => radius}
    
    with {:ok, %Code{} = code} <- Promo.create_code(params) do
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

  def update(conn, params) do
    {amount, _} = Integer.parse(params["amount"])
    {_, expiry_date} = Date.from_iso8601(params["expiry_date"])
    event_location = Jason.decode!(params["event_location"])
    {radius, _} = Integer.parse(params["radius"])
    params = %{params | "amount" => amount, "expiry_date" => expiry_date, 
        "event_location" => event_location, "radius" => radius}
    code = Promo.get_code!(params["id"])

    with {:ok, %Code{} = code} <- Promo.update_code(code, params) do
      render(conn, "show.json", code: code)
    end
  end

  def delete(conn, %{"id" => id}) do
    code = Promo.get_code!(id)

    with {:ok, %Code{}} <- Promo.delete_code(code) do
      send_resp(conn, :no_content, "")
    end
  end

  def active(conn, _params) do
    codes = Promo.list_active_codes()
    render(conn, "index.json", codes: codes)
  end

  def promo(conn, params) do
    response = valid(params)
    
    with {:ok, code} <- response do
      render(conn, "show.json", code: code)
    # else
    #   {:error, message} -> message
    end
  end

  defp valid(params) do
    code = Promo.get_code_by_code!(params["code"])
    origin = Jason.decode!(params["origin"])
    destination = Jason.decode!(params["destination"])
    origin_valid? = Geocalc.within?(100000, code.event_location, origin)
    destination_valid? = Geocalc.within?(100000, code.event_location, destination)
    
    cond do
      origin_valid? == false -> {:error, "Origin is invalid"}
      destination_valid? == false -> {:error, "Destination is invalid"}
      origin_valid? && destination_valid? == true -> {:ok, code}
    end
  end
end
