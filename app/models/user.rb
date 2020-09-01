# rubocop:disable Layout/LineLength
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: :befriender_id, inverse_of: :befriender, dependent: :destroy
  has_many :received_requests, class_name: 'FriendRequest', foreign_key: :befriendee_id, inverse_of: :befriendee, dependent: :destroy
  has_many :confirmed_requests, -> { where(status: 'accepted') }, class_name: 'FriendRequest', foreign_key: :befriender_id
  has_many :confirmed_friends, through: :confirmed_requests, source: :befriendee
  has_many :pending_requests, -> { includes(:befriender).where(status: 'pending') }, class_name: 'FriendRequest', foreign_key: :befriendee_id
  has_many :pending_friends, through: :pending_requests, source: :befriender

  def confirmed_friend?(user, current_user)
    !current_user.confirmed_friends.find_by(email: user.email).nil?
  end

  def pending_friend?(user, current_user)
    !current_user.pending_friends.find_by(email: user.email).nil?
  end
end

# rubocop:enable Layout/LineLength
