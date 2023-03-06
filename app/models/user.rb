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
  has_many :chatrooms, through: :messages
  # is this new through: association correct?

  validates :username, presence: true, uniqueness: true, length: { minimum: 2 }
  validates :first_name, presence: true
end
