class Recipe < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :steps, dependent: :destroy

  validates :title, uniqueness: true, presence: true
  validates :instructions, :total_time, :serving_size, :image_url, presence: true
  # validates :prep_time, :cooking_time, presence: true

  include PgSearch::Model
  pg_search_scope :search_recipes,
                  against: %i[title instructions],
                  using: { tsearch: { prefix: true } }

  scope :order_by_average_rating_asc, -> { order(:average_rating) }
  scope :order_by_average_rating_desc, -> { order(average_rating: :desc) }

  def update_average_rating
    update(average_rating: reviews.average(:rating))
  end

  # scope :with_total_time, ->(total_time) {
  #   where('total_time <= ?', total_time.to_i) unless total_time.blank?
  # }

  # scope :with_ingredients, ->(ingredients) {
  #   joins(:ingredients).where("ingredients.name IN (?)", ingredients) unless ingredients.blank?
  # }
  # from recipes controller: @recipes.with_ingredients(params[:ingredients].split(',')) if params[:ingredients].present?

  # def self.search(query)
  #   if query.present?
  #     search_by_title_and_instructions(query)
  #   else
  #     all
  #   end
  # end

  # def self.sorted_by(sort_option)
  #   direction = /desc$/.match?(sort_option) ? "desc" : "asc"
  #   case sort_option.to_s
  #   when /^title_/
  #     order("title #{direction}")
  #   when /^created_at_/
  #     order("created_at #{direction}")
  #   else
  #     raise ArgumentError, "Invalid sort option: #{sort_option.inspect}"
  #   end
  # end
end
