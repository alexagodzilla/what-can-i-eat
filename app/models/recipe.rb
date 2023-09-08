class Recipe < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :steps, dependent: :destroy

  validates :title, uniqueness: true, presence: true
  validates :instructions, :total_time, :serving_size, :image_url, presence: true

  include PgSearch::Model
  pg_search_scope :search_recipes,
                  against: %i[title instructions],
                  using: { tsearch: { prefix: true } }

  scope :order_by_average_rating_asc, -> { order(:average_rating) }
  scope :order_by_average_rating_desc, -> { order(average_rating: :desc) }

  def update_average_rating
    update(average_rating: reviews.average(:rating))
  end
end
