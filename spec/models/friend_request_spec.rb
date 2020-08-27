require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:befriender).class_name('User') }
    it { is_expected.to belong_to(:befriendee).class_name('User') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:befriender) }
    it { is_expected.to validate_presence_of(:befriendee) }
  end
end
