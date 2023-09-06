class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :reviews
  has_many :user_ingredients, dependent: :destroy
  has_many :ingredients, through: :user_ingredients
  has_many :messages

  has_many :requester_friendships, class_name: 'Friendship', foreign_key: 'requester_id'
  has_many :requested_friendships, class_name: 'Friendship', foreign_key: 'requested_id'

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :first_name, presence: true

  def friends
    friend_ids = requester_friendships.where(status: "accepted").pluck(:requested_id) +
                 requested_friendships.where(status: "accepted").pluck(:requester_id)
    User.where(id: friend_ids)
  end

  def pending_friends
    friend_ids = requested_friendships.where(status: "pending").pluck(:requester_id)
    User.where(id: friend_ids)
  end

  def invites_sent
    friend_ids = requester_friendships.where(status: "pending").pluck(:requested_id)
    User.where(id: friend_ids)
  end
end

# has_many :requesters, class_name: 'User', through: :requested_friendships
# has_many :requesteds, class_name: 'User', through: :requester_friendships
# these return the user instance but not filtered by status, so believe not useful
