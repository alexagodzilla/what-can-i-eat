class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates :recipe_id, presence: true, uniqueness: { scope: :user_id }
end
