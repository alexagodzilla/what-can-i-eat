class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :users, through: :user_ingredients
  has_many :user_ingredients


  validates :name, presence: true
end
