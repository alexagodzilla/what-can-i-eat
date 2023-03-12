class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :rating, inclusion: { in: 0..5 }

  after_save :update_recipe_average_rating
  after_destroy :update_recipe_average_rating

  def update_recipe_average_rating
    recipe.update_average_rating
  end
end
