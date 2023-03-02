class Recipe < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :title, uniqueness: true, presence: true
  validates :instructions, :total_time, :serving_size, :image_url, presence: true
  validates :prep_time, :cooking_time, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_title_and_instructions,
                  against: [:title, :instructions],
                  using: { tsearch: { prefix: true } }
  
  # scope :vegetarian, -> { where(vegetarian: true) }
  # scope :vegan, -> { where(vegan: true) }
  # scope :gluten_free, -> { where(gluten_free: true) }
  # scope :dairy_free, -> { where(dairy_free: true) }

  # scope :with_total_time, ->(total_time) {
  #   where('total_time <= ?', total_time.to_i) unless total_time.blank?
  # }

  # scope :with_ingredients, ->(ingredients) {
  #   joins(:ingredients).where("ingredients.name IN (?)", ingredients) unless ingredients.blank?
  # }

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
