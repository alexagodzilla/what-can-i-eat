class Friendship < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requested, class_name: 'User'
  # requesters are people the user has sent a friend request to
  # requesteds are people the user has received a friend request from

  validates :requester, uniqueness: { scope: :requested }
  validates :status, presence: true, inclusion: { in: %w[accepted rejected pending] }
end
