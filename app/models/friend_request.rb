class FriendRequest < ApplicationRecord
  belongs_to :befriender, class_name: 'User'
  belongs_to :befriendee, class_name: 'User'

  validates :befriender, :befriendee, presence: true

  before_save :set_pending, on: :create
  before_update :set_accepted
  after_update :add_reverse_friendship
  after_rollback :add_reverse_friendship, on: :create, if: :accepted?

  def self.pending_request(user, current_user)
    current_user.pending_requests.find_by(befriender: user)
  end

  def self.invited?(user)
    find_by(befriendee: user, status: 'pending').nil?
  end

  private

  def set_pending
    self.status = 'pending' if status.nil?
  end

  def set_accepted
    self.status = 'accepted' if status == 'pending'
  end

  def add_reverse_friendship
    FriendRequest.create(befriender: befriendee, befriendee: befriender, status: 'accepted')
  end

  def accepted?
    status == 'accepted'
  end
end
