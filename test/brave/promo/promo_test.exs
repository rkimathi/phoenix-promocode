defmodule Brave.PromoTest do
  use Brave.DataCase

  alias Brave.Promo

  describe "codes" do
    alias Brave.Promo.Code

    @valid_attrs %{
      code: "some code",
      amount: 1234,
      expiry_date: ~D[2000-01-01],
      is_active: true,
      event_location: [1.23456789, 9.87654321],
      radius: 12
    }
    @update_attrs %{
      code: "some updated code",
      amount: 4321,
      expiry_date: ~D[1970-01-01],
      is_active: false,
      event_location: [9.87654321, 1.23456789],
      radius: 21
    }
    @invalid_attrs %{
      code: nil,
      amount: nil,
      expiry_date: nil,
      is_active: nil,
      event_location: nil,
      radius: nil
    }

    def code_fixture(attrs \\ %{}) do
      {:ok, code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Promo.create_code()

      code
    end

    test "list_codes/0 returns all codes" do
      code = code_fixture()
      assert Promo.list_codes() == [code]
    end

    test "get_code!/1 returns the code with given id" do
      code = code_fixture()
      assert Promo.get_code!(code.id) == code
    end

    test "create_code/1 with valid data creates a code" do
      assert {:ok, %Code{} = code} = Promo.create_code(@valid_attrs)
      assert code.code == "some code"
      assert code.amount == 1234
      assert code.expiry_date == ~D[2000-01-01]
      assert code.is_active == true
      assert code.event_location == [1.23456789, 9.87654321]
      assert code.radius == 12
    end

    test "create_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Promo.create_code(@invalid_attrs)
    end

    test "update_code/2 with valid data updates the code" do
      code = code_fixture()
      assert {:ok, %Code{} = code} = Promo.update_code(code, @update_attrs)
      assert code.code == "some updated code"
      assert code.amount == 4321
      assert code.expiry_date == ~D[1970-01-01]
      assert code.is_active == false
      assert code.event_location == [9.87654321, 1.23456789]
      assert code.radius == 21
    end

    test "update_code/2 with invalid data returns error changeset" do
      code = code_fixture()
      assert {:error, %Ecto.Changeset{}} = Promo.update_code(code, @invalid_attrs)
      assert code == Promo.get_code!(code.id)
    end

    test "delete_code/1 deletes the code" do
      code = code_fixture()
      assert {:ok, %Code{}} = Promo.delete_code(code)
      assert_raise Ecto.NoResultsError, fn -> Promo.get_code!(code.id) end
    end

    test "change_code/1 returns a code changeset" do
      code = code_fixture()
      assert %Ecto.Changeset{} = Promo.change_code(code)
    end
  end
end
