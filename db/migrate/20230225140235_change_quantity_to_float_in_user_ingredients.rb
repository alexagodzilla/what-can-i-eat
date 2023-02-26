class ChangeQuantityToFloatInUserIngredients < ActiveRecord::Migration[7.0]
  def change
    change_column :user_ingredients, :quantity, :float
  end
end
