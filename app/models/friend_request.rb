class FriendRequest < ApplicationRecord
  belongs_to :befriender, class_name: 'User'
  belongs_to :befriendee, class_name: 'User'

  validates :befriender, :befriendee, presence: true

  def self.pending_request(user, current_user)
    current_user.pending_requests.find_by(befriender: user)
  end

  def self.invited?(user)
    find_by(befriendee: user, status: 'pending').nil?
  end
end
