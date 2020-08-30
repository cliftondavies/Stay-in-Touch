# rubocop:disable Layout/LineLength
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:sent_requests).class_name('FriendRequest').with_foreign_key(:befriender_id).inverse_of(:befriender) }
    it { is_expected.to have_many(:received_requests).class_name('FriendRequest').with_foreign_key(:befriendee_id).inverse_of(:befriendee) }
    it { is_expected.to have_many(:befriendees).through(:sent_requests) }
    it { is_expected.to have_many(:befrienders).through(:received_requests) }
    it { is_expected.to have_and_belong_to_many(:friends).class_name('User').join_table('friends_users') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(20) }
  end
end

# rubocop:enable Layout/LineLength
