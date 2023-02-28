class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :rating, inclusion: { in: 0..5 }
end
