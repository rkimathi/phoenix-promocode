defmodule Brave.Promo.Code do
  use Ecto.Schema
  import Ecto.Changeset


  schema "codes" do
    field :code, :string

    timestamps()
  end

  @doc false
  def changeset(code, attrs) do
    code
    |> cast(attrs, [:code])
    |> validate_required([:code])
    |> unique_constraint(:code)
  end
end
