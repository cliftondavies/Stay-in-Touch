class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: :befriender_id, inverse_of: :befriender
  has_many :received_requests, class_name: 'FriendRequest', foreign_key: :befriendee_id, inverse_of: :befriendee

  def confirmed_requests
    self.sent_requests.where(status: 'accepted') + self.received_requests.where(status: 'accepted')
  end

  def pending_invites
    received_requests.includes(:befriender).where(status: 'pending')
  end

  def friend?(user)
    confirmed_requests.find { |request| request.befriender == user || request.befriendee == user } ||
    self.sent_requests.find_by(befriendee: user, befriender: self, status: 'pending')
  end
end
