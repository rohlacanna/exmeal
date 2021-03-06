defmodule Exmeal.Meals.UpdateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Error, Meal}
  alias Exmeal.Meals.Update

  describe "call/1" do
    test "when meal exists, updates the meal" do
      insert(:user)
      insert(:meal)

      params = %{
        "id" => "47d5430a-9569-40d7-9a33-222aaedb8e29",
        "descricao" => "Abacate"
      }

      response =
        params
        |> Update.call()

      assert {
               :ok,
               %Meal{
                 id: _id,
                 descricao: "Abacate",
                 calorias: 300,
                 data: ~U[2021-03-28 13:59:13Z]
               }
             } = response
    end

    test "when meal not exists, returns an error" do
      params = %{
        "id" => "47d5430a-9569-40d7-9a33-222aaedb8e29",
        "descricao" => "Abacate"
      }

      response = Update.call(params)

      assert {
               :error,
               %Error{
                 message: "Meal not found",
                 status: :not_found
               }
             } = response
    end
  end
end
