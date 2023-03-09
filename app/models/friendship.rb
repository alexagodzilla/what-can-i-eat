class Friendship < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requested, class_name: 'User'

  validates :requester, uniqueness: { scope: :requested }
  validates :status, presence: true, inclusion: { in: %w[accepted rejected pending] }

  scope :accepted, -> { where(status: 'accepted') }
  scope :rejected, -> { where(status: 'rejected') }
  scope :pending, -> { where(status: 'pending') }
end
