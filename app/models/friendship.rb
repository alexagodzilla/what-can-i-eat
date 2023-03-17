class Friendship < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requested, class_name: 'User'
  # requesters are people the user has sent a friend request to
  # requesteds are people the user has received a friend request from

  validates :requester, uniqueness: { scope: :requested }
  validates :status, presence: true, inclusion: { in: %w[accepted rejected pending] }

  def self.exist?(logged_in_user, other_user)
    option1 = Friendship.where(requester: other_user, requested: logged_in_user).present?
    option2 = Friendship.where(requester: logged_in_user, requested: other_user).present?
    option1 || option2
  end
end

f = Friendship.first(5)
f.each do |friendship|
  friendship.status = "accepted"
end
