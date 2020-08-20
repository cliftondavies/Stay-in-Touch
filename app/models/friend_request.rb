class FriendRequest < ApplicationRecord
  belongs_to :befriender, class_name: 'User'
  belongs_to :befriendee, class_name: 'User'

  validates :befriender, :befriendee, presence: true
end
