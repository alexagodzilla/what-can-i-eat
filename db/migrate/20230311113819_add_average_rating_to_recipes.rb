class AddAverageRatingToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :average_rating, :float
  end
end
