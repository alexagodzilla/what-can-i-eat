class Recipe < ApplicationRecord
include PgSearch::Model

  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :title, uniqueness: true, presence: true
  validates :instructions, :total_time, :serving_size, :image_url, presence: true
  # validates :prep_time, :cooking_time, presence: true

  pg_search_scope :search_by_ingredient_names,
    associated_against: {
      ingredients: :name
    }

end
