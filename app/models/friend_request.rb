class FriendRequest < ApplicationRecord
  belongs_to :befriender, class_name: 'User'
  belongs_to :befriendee, class_name: 'User'

  validates :befriender, :befriendee, presence: true

  scope :pending_invites, -> { includes(:befriender).where(status: 'pending') }

  def self.pending_request(user, current_user)
    find_by(befriender: user, befriendee: current_user)
  end
end
