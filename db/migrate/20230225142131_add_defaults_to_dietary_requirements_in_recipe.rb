class AddDefaultsToDietaryRequirementsInRecipe < ActiveRecord::Migration[7.0]
  def change
    change_column_default :recipes, :vegetarian, false
    change_column_default :recipes, :vegan, false
    change_column_default :recipes, :dairy_free, false
    change_column_default :recipes, :gluten_free, false
  end
end
