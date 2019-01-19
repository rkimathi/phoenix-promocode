defmodule BraveWeb.CodeView do
  use BraveWeb, :view
  alias BraveWeb.CodeView

  def render("index.json", %{codes: codes}) do
    %{data: render_many(codes, CodeView, "code.json")}
  end

  def render("show.json", %{code: code}) do
    %{data: render_one(code, CodeView, "code.json")}
  end

  def render("code.json", %{code: code}) do
    %{id: code.id,
      code: code.code,
      amount: code.amount,
      expiry_date: code.expiry_date,
      is_active: code.is_active,
      event_location: code.event_location,
      radius: code.radius}
  end
end
