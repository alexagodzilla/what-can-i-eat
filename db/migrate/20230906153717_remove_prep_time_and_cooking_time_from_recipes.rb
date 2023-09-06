class RemovePrepTimeAndCookingTimeFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :prep_time, :integer
    remove_column :recipes, :cooking_time, :integer
  end
end
