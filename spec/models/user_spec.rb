# rubocop:disable Layout/LineLength
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:sent_requests).class_name('FriendRequest').with_foreign_key(:befriender_id).inverse_of(:befriender).dependent(:destroy) }
    it { is_expected.to have_many(:received_requests).class_name('FriendRequest').with_foreign_key(:befriendee_id).inverse_of(:befriendee).dependent(:destroy) }
    it { is_expected.to have_many(:confirmed_requests).conditions(status: 'accepted').class_name('FriendRequest').with_foreign_key(:befriender_id) }
    it { is_expected.to have_many(:confirmed_friends).through(:confirmed_requests).source(:befriendee) }
    it { is_expected.to have_many(:pending_requests).class_name('FriendRequest').with_foreign_key(:befriendee_id) }
    it { is_expected.to have_many(:pending_friends).through(:pending_requests).source(:befriender) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(20) }
  end
end

# rubocop:enable Layout/LineLength
