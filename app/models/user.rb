class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_requests, foreign_key: :befriender_id, inverse_of: :befriender
  has_many :friend_requests, foreign_key: :befriendee_id, inverse_of: :befriendee
  has_many :befrienders, through: :friend_requests
  has_many :befriendees, through: :friend_requests
end
