class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :rating, inclusion: { in: 0..5 }
  validates :user_id, uniqueness: {
    scope: :recipe_id,
    message: "You can't leave more than one review per recipe!"
  }

  after_save :update_recipe_average_rating
  after_destroy :update_recipe_average_rating

  private

  def update_recipe_average_rating
    recipe.update_average_rating
  end
end
