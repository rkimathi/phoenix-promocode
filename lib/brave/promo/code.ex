defmodule Brave.Promo.Code do
  use Ecto.Schema
  import Ecto.Changeset


  schema "codes" do
    field :code, :string
    field :amount, :integer
    field :expiry_date, :date
    field :is_active, :boolean, default: true
    field :event_location, {:array, :float}
    field :radius, :integer

    timestamps()
  end

  @doc false
  def changeset(code, attrs) do
    code
    |> cast(attrs, [:code, :amount, :expiry_date, :is_active, :event_location, :radius])
    |> validate_required([:code, :amount, :expiry_date, :is_active, :event_location, :radius])
    |> unique_constraint(:code)
  end
end
