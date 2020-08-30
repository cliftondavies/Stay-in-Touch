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
  has_many :befriendees, -> { (FriendRequest.sent(User.first)) }, through: :sent_requests
  has_many :befrienders, -> { (FriendRequest.received(User.first)) }, through: :received_requests
  # has_and_belongs_to_many :users, foreign_key: :friend_id, join_table: 'users'
  has_and_belongs_to_many :friends, class_name: 'User', join_table: 'friends_users', foreign_key: :user_id, association_foreign_key: :friend_id

  # def self.friends(current_user) # can be moved to view helper
  #   current_user.befriendees << current_user.befrienders # << returns relation ( + returns array ) of friends as User objects
  #   # FriendRequest.sent(current_user).or(FriendRequest.received(current_user)) returns relation of AFR objects for the user
  # end

  def confirmed_requests # returns array of approved friend requests objects for the user
    sent_requests.includes(:befriendee).where(status: 'accepted', befriender: self) +
      received_requests.includes(:befriender).where(status: 'accepted', befriendee: self)
  end

  def friend?(user)
    confirmed_requests.any? { |request| [request.befriender, request.befriendee].include?(user) } ||
      !sent_requests.find_by(befriendee: user, befriender: self, status: 'pending').nil? ||
      pending_invite?(user)
  end

  def pending_invite?(user)
    !received_requests.pending_invites.find_by(befriender: user, befriendee: self).nil?
  end
end
