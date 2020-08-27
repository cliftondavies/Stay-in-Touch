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
    sent_requests.includes(:befriendee).where(status: 'accepted', befriender: self) +
      received_requests.includes(:befriender).where(status: 'accepted', befriendee: self)
  end

  def friend?(user)
    confirmed_requests.find { |request| [request.befriender, request.befriendee].include?(user) } ||
      sent_requests.find_by(befriendee: user, befriender: self, status: 'pending') ||
      pending_invite?(user)
  end

  def pending_invite?(user)
    received_requests.pending_invites.find_by(befriender: user, befriendee: self)
  end
end
